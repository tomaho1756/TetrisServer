use axum::{
    extract::{Path, State, Query},
    http::StatusCode,
    response::Json,
    Extension,
};
use uuid::Uuid;
use serde::{Deserialize, Serialize};
use serde_json::json;
use crate::{AppState, models::*};

// 사용자 등록 핸들러
pub async fn register_user(
    State(state): State<AppState>,
    Json(payload): Json<RegisterRequest>,
) -> Result<Json<AuthResponse>, StatusCode> {
    let user = state
        .user_service
        .register_user(payload.username, payload.email, payload.password)
        .await
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    let token = state
        .user_service
        .generate_jwt_token(user.id)
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(AuthResponse { token, user }))
}

// 사용자 로그인 핸들러
pub async fn login_user(
    State(state): State<AppState>,
    Json(payload): Json<LoginRequest>,
) -> Result<Json<AuthResponse>, StatusCode> {
    let (user, token) = state
        .user_service
        .login_user(payload.email, payload.password)
        .await
        .map_err(|_| StatusCode::UNAUTHORIZED)?;

    Ok(Json(AuthResponse { token, user }))
}

// 싱글플레이 게임 시작 핸들러
pub async fn start_single_game(
    State(state): State<AppState>,
    Json(payload): Json<StartGameRequest>,
) -> Result<Json<GameStateResponse>, StatusCode> {
    let player_id = Uuid::parse_str(&payload.player_id)
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    let game_id = state
        .game_service
        .create_game(player_id, payload.game_mode)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    // 플레이어 정보 가져오기
    let user = state
        .user_service
        .get_user_by_id(player_id)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?
        .ok_or(StatusCode::NOT_FOUND)?;

    let player_info = PlayerInfo {
        id: user.id.to_string(),
        username: user.username,
        avatar_path: user.avatar_path,
        rating: Some(user.rating),
        is_online: true,
        status: PlayerStatus::InGame,
    };

    // 게임에 플레이어 추가
    state
        .game_service
        .join_game(game_id, player_id, player_info)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    // 게임 시작
    state
        .game_service
        .start_game(game_id)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    // 게임 상태 반환
    let session = state
        .game_service
        .get_game_state(game_id)
        .await
        .map_err(|_| StatusCode::NOT_FOUND)?;

    let board = session
        .game_boards
        .get(&player_id)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(GameStateResponse {
        game_id: game_id.to_string(),
        status: session.status,
        current_player: session.current_turn.map(|id| id.to_string()),
        game_board: board.clone(),
        score: board.score,
        level: board.level,
        lines_cleared: board.lines_cleared,
        next_piece: board.next_pieces.front().copied().unwrap_or(TetrominoType::I),
    }))
}

// 플레이어 액션 처리 핸들러
pub async fn make_move(
    State(state): State<AppState>,
    Path(game_id): Path<Uuid>,
    Json(payload): Json<GameMoveRequest>,
) -> Result<Json<GameStateResponse>, StatusCode> {
    let player_id = Uuid::parse_str(&payload.player_id)
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    // 액션 처리
    state
        .game_service
        .handle_player_action(game_id, player_id, payload.action)
        .await
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    // 업데이트된 게임 상태 반환
    let session = state
        .game_service
        .get_game_state(game_id)
        .await
        .map_err(|_| StatusCode::NOT_FOUND)?;

    let board = session
        .game_boards
        .get(&player_id)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(GameStateResponse {
        game_id: game_id.to_string(),
        status: session.status,
        current_player: session.current_turn.map(|id| id.to_string()),
        game_board: board.clone(),
        score: board.score,
        level: board.level,
        lines_cleared: board.lines_cleared,
        next_piece: board.next_pieces.front().copied().unwrap_or(TetrominoType::I),
    }))
}

// 게임 상태 조회 핸들러
pub async fn get_game_state(
    State(state): State<AppState>,
    Path(game_id): Path<Uuid>,
) -> Result<Json<GameStateResponse>, StatusCode> {
    let session = state
        .game_service
        .get_game_state(game_id)
        .await
        .map_err(|_| StatusCode::NOT_FOUND)?;

    // 첫 번째 플레이어의 보드를 기본으로 반환
    let first_player = session.players.first().ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;
    let board = session
        .game_boards
        .get(first_player)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(GameStateResponse {
        game_id: game_id.to_string(),
        status: session.status,
        current_player: session.current_turn.map(|id| id.to_string()),
        game_board: board.clone(),
        score: board.score,
        level: board.level,
        lines_cleared: board.lines_cleared,
        next_piece: board.next_pieces.front().copied().unwrap_or(TetrominoType::I),
    }))
}

// 게임 나가기 핸들러
pub async fn leave_game(
    State(state): State<AppState>,
    Path(game_id): Path<Uuid>,
    Extension(user_id): Extension<Uuid>,
) -> Result<StatusCode, StatusCode> {
    state
        .game_service
        .leave_game(game_id, user_id)
        .await
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    Ok(StatusCode::OK)
}

// 사용자 통계 조회 핸들러
pub async fn get_user_stats(
    State(state): State<AppState>,
    Path(user_id): Path<Uuid>,
) -> Result<Json<UserStatsResponse>, StatusCode> {
    let profile = state
        .user_service
        .get_user_profile(user_id)
        .await
        .map_err(|_| StatusCode::NOT_FOUND)?;

    Ok(Json(UserStatsResponse {
        user_id: profile.user.id.to_string(),
        username: profile.user.username,
        total_games: profile.stats.total_games,
        wins: profile.stats.wins,
        losses: profile.stats.losses,
        highest_score: profile.stats.highest_score,
        total_lines_cleared: profile.stats.total_lines_cleared,
        average_score: profile.stats.average_score,
    }))
}

// 리더보드 조회 핸들러
pub async fn get_leaderboard(
    State(state): State<AppState>,
    Query(params): Query<LeaderboardQuery>,
) -> Result<Json<Vec<UserStatsResponse>>, StatusCode> {
    let limit = params.limit.unwrap_or(10).min(100); // 최대 100개로 제한

    let leaderboard = state
        .db
        .get_leaderboard(limit)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(leaderboard))
}

#[derive(Deserialize)]
pub struct LeaderboardQuery {
    limit: Option<u32>,
}

// 게임 통계 저장 핸들러
pub async fn save_game_stats(
    State(state): State<AppState>,
    Json(payload): Json<SaveGameStatsRequest>,
) -> Result<StatusCode, StatusCode> {
    let user_id = Uuid::parse_str(&payload.user_id)
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    let mut stats = GameStats::new(
        user_id,
        payload.game_mode,
        payload.score,
        payload.lines_cleared,
        payload.level_reached,
        payload.duration,
    );

    stats.is_victory = payload.is_victory.unwrap_or(false);
    stats.placement = payload.placement;
    stats.calculate_derived_stats(payload.total_pieces.unwrap_or(0), payload.total_actions.unwrap_or(0));

    state
        .db
        .save_game_stats(&stats)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(StatusCode::CREATED)
}

#[derive(Deserialize)]
pub struct SaveGameStatsRequest {
    user_id: String,
    game_mode: GameMode,
    score: u32,
    lines_cleared: u32,
    level_reached: u32,
    duration: u32,
    is_victory: Option<bool>,
    placement: Option<u32>,
    total_pieces: Option<u32>,
    total_actions: Option<u32>,
}

// 매칭 요청 핸들러
pub async fn request_matching(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
    Json(payload): Json<MatchingRequest>,
) -> Result<Json<MatchingResponse>, StatusCode> {
    // 기존 매칭 가능한 게임 찾기
    if let Some(game_id) = state.game_service.find_matchable_game(payload.game_mode.clone()).await {
        // 사용자 정보 가져오기
        let user = state
            .user_service
            .get_user_by_id(user_id)
            .await
            .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?
            .ok_or(StatusCode::NOT_FOUND)?;

        let player_info = PlayerInfo {
            id: user.id.to_string(),
            username: user.username,
            avatar_path: user.avatar_path,
            rating: Some(user.rating),
            is_online: true,
            status: PlayerStatus::InGame,
        };

        // 게임에 참가
        state
            .game_service
            .join_game(game_id, user_id, player_info)
            .await
            .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

        return Ok(Json(MatchingResponse {
            status: "matched".to_string(),
            game_id: Some(game_id.to_string()),
            estimated_wait_time: None,
        }));
    }

    // 매칭 가능한 게임이 없으면 새 게임 생성
    let game_id = state
        .game_service
        .create_game(user_id, payload.game_mode)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(MatchingResponse {
        status: "waiting".to_string(),
        game_id: Some(game_id.to_string()),
        estimated_wait_time: Some(30), // 30초 예상 대기시간
    }))
}

#[derive(Deserialize)]
pub struct MatchingRequest {
    game_mode: GameMode,
}

#[derive(Serialize)]
pub struct MatchingResponse {
    status: String,
    game_id: Option<String>,
    estimated_wait_time: Option<u32>,
}

// 매칭 취소 핸들러
pub async fn cancel_matching(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
) -> Result<StatusCode, StatusCode> {
    // TODO: 매칭 취소 로직 구현
    Ok(StatusCode::OK)
}

// 방 목록 조회 핸들러
pub async fn list_rooms(
    State(state): State<AppState>,
    Query(params): Query<RoomListQuery>,
) -> Result<Json<Vec<RoomData>>, StatusCode> {
    let rooms = state
        .room_service
        .list_rooms(params.page.unwrap_or(0), params.limit.unwrap_or(20))
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(rooms))
}

#[derive(Deserialize)]
pub struct RoomListQuery {
    page: Option<u32>,
    limit: Option<u32>,
}

// 방 생성 핸들러
pub async fn create_room(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
    Json(payload): Json<CreateRoomRequest>,
) -> Result<Json<RoomData>, StatusCode> {
    let room = state
        .room_service
        .create_room(user_id, payload)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(room))
}

// 방 정보 조회 핸들러
pub async fn get_room(
    State(state): State<AppState>,
    Path(room_id): Path<String>,
) -> Result<Json<RoomData>, StatusCode> {
    let room = state
        .room_service
        .get_room(&room_id)
        .await
        .map_err(|_| StatusCode::NOT_FOUND)?;

    Ok(Json(room))
}

// 방 참가 핸들러
pub async fn join_room(
    State(state): State<AppState>,
    Path(room_id): Path<String>,
    Extension(user_id): Extension<Uuid>,
    Json(payload): Json<JoinRoomByIdRequest>,
) -> Result<Json<RoomData>, StatusCode> {
    let room = state
        .room_service
        .join_room(&room_id, user_id, payload.password)
        .await
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    Ok(Json(room))
}

#[derive(Deserialize)]
pub struct JoinRoomByIdRequest {
    password: Option<String>,
}

// 방 나가기 핸들러
pub async fn leave_room(
    State(state): State<AppState>,
    Path(room_id): Path<String>,
    Extension(user_id): Extension<Uuid>,
) -> Result<StatusCode, StatusCode> {
    state
        .room_service
        .leave_room(&room_id, user_id)
        .await
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    Ok(StatusCode::OK)
}

// 방 코드로 참가 핸들러
pub async fn join_room_by_code(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
    Json(payload): Json<JoinRoomRequest>,
) -> Result<Json<RoomData>, StatusCode> {
    let room = state
        .room_service
        .join_room_by_code(&payload.room_code, user_id, payload.password)
        .await
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    Ok(Json(room))
}

// 방에서 게임 시작 핸들러
pub async fn start_room_game(
    State(state): State<AppState>,
    Path(room_id): Path<String>,
    Extension(user_id): Extension<Uuid>,
) -> Result<Json<GameStateResponse>, StatusCode> {
    let game_id = state
        .room_service
        .start_game(&room_id, user_id)
        .await
        .map_err(|_| StatusCode::BAD_REQUEST)?;

    // 게임 상태 반환
    let session = state
        .game_service
        .get_game_state(game_id)
        .await
        .map_err(|_| StatusCode::NOT_FOUND)?;

    let board = session
        .game_boards
        .get(&user_id)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(Json(GameStateResponse {
        game_id: game_id.to_string(),
        status: session.status,
        current_player: session.current_turn.map(|id| id.to_string()),
        game_board: board.clone(),
        score: board.score,
        level: board.level,
        lines_cleared: board.lines_cleared,
        next_piece: board.next_pieces.front().copied().unwrap_or(TetrominoType::I),
    }))
}

// 채팅 메시지 조회 핸들러
pub async fn get_chat_messages(
    State(state): State<AppState>,
    Path(room_id): Path<String>,
    Query(params): Query<ChatQuery>,
) -> Result<Json<Vec<ChatMessageData>>, StatusCode> {
    // TODO: 채팅 메시지 조회 구현
    Ok(Json(vec![]))
}

#[derive(Deserialize)]
pub struct ChatQuery {
    limit: Option<u32>,
    before: Option<String>,
}

// 채팅 메시지 전송 핸들러
pub async fn send_chat_message(
    State(state): State<AppState>,
    Path(room_id): Path<String>,
    Extension(user_id): Extension<Uuid>,
    Json(payload): Json<SendChatRequest>,
) -> Result<StatusCode, StatusCode> {
    // TODO: 채팅 메시지 전송 구현
    Ok(StatusCode::OK)
}

// 친구 목록 조회 핸들러 (미래 구현)
pub async fn get_friends(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
) -> Result<Json<Vec<Friend>>, StatusCode> {
    // TODO: 친구 목록 조회 구현
    Ok(Json(vec![]))
}

// 친구 요청 목록 조회 핸들러 (미래 구현)
pub async fn get_friend_requests(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
) -> Result<Json<Vec<FriendRequest>>, StatusCode> {
    // TODO: 친구 요청 목록 조회 구현
    Ok(Json(vec![]))
}

// 친구 요청 전송 핸들러 (미래 구현)
pub async fn send_friend_request(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
    Json(payload): Json<SendFriendRequestRequest>,
) -> Result<StatusCode, StatusCode> {
    // TODO: 친구 요청 전송 구현
    Ok(StatusCode::CREATED)
}

// 친구 요청 수락 핸들러 (미래 구현)
pub async fn accept_friend_request(
    State(state): State<AppState>,
    Path(friend_id): Path<Uuid>,
    Extension(user_id): Extension<Uuid>,
) -> Result<StatusCode, StatusCode> {
    // TODO: 친구 요청 수락 구현
    Ok(StatusCode::OK)
}

// 친구 요청 거절 핸들러 (미래 구현)
pub async fn decline_friend_request(
    State(state): State<AppState>,
    Path(friend_id): Path<Uuid>,
    Extension(user_id): Extension<Uuid>,
) -> Result<StatusCode, StatusCode> {
    // TODO: 친구 요청 거절 구현
    Ok(StatusCode::OK)
}

// 친구 삭제 핸들러 (미래 구현)
pub async fn remove_friend(
    State(state): State<AppState>,
    Path(friend_id): Path<Uuid>,
    Extension(user_id): Extension<Uuid>,
) -> Result<StatusCode, StatusCode> {
    // TODO: 친구 삭제 구현
    Ok(StatusCode::OK)
}

// 관리자 통계 조회 핸들러 (미래 구현)
pub async fn get_admin_stats(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
) -> Result<Json<AdminStats>, StatusCode> {
    // TODO: 관리자 권한 확인 및 통계 조회 구현
    Ok(Json(AdminStats {
        total_users: 0,
        online_users: 0,
        active_games: 0,
        total_games_played: 0,
        active_rooms: 0,
        server_uptime: 0,
        top_players: vec![],
    }))
}

// 모든 사용자 조회 핸들러 (미래 구현)
pub async fn get_all_users(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
) -> Result<Json<Vec<User>>, StatusCode> {
    // TODO: 관리자 권한 확인 및 사용자 목록 조회 구현
    Ok(Json(vec![]))
}

// 모든 게임 조회 핸들러 (미래 구현)
pub async fn get_all_games(
    State(state): State<AppState>,
    Extension(user_id): Extension<Uuid>,
) -> Result<Json<Vec<GameSession>>, StatusCode> {
    // TODO: 관리자 권한 확인 및 게임 목록 조회 구현
    Ok(Json(vec![]))
}

// 사용자 밴 핸들러 (미래 구현)
pub async fn ban_user(
    State(state): State<AppState>,
    Path(target_user_id): Path<Uuid>,
    Extension(admin_user_id): Extension<Uuid>,
) -> Result<StatusCode, StatusCode> {
    // TODO: 관리자 권한 확인 및 사용자 밴 구현
    Ok(StatusCode::OK)
}

// JWT 인증 미들웨어
pub async fn auth_middleware(
    State(state): State<AppState>,
    mut req: axum::extract::Request,
    next: axum::middleware::Next,
) -> Result<axum::response::Response, StatusCode> {
    let auth_header = req
        .headers()
        .get("Authorization")
        .and_then(|header| header.to_str().ok())
        .and_then(|header| header.strip_prefix("Bearer "));

    if let Some(token) = auth_header {
        match state.user_service.verify_jwt_token(token) {
            Ok(user_id) => {
                req.extensions_mut().insert(user_id);
                Ok(next.run(req).await)
            }
            Err(_) => Err(StatusCode::UNAUTHORIZED),
        }
    } else {
        Err(StatusCode::UNAUTHORIZED)
    }
}

// WebSocket 핸들러
pub async fn websocket_handler(socket: socketioxide::extract::SocketRef, state: AppState) {
    println!("🔌 새로운 WebSocket 연결: {}", socket.id);

    // 인증 처리
    socket.on("authenticate", move |socket: socketioxide::extract::SocketRef, data: serde_json::Value| {
        let state = state.clone();
        async move {
            if let Ok(auth_data) = serde_json::from_value::<AuthenticateData>(data) {
                match state.user_service.verify_jwt_token(&auth_data.token) {
                    Ok(user_id) => {
                        if let Ok(Some(user)) = state.user_service.get_user_by_id(user_id).await {
                            // 사용자 연결 등록
                            state.websocket_service.connect_user(socket.id.to_string(), &user).await;
                            
                            let _ = socket.emit("authenticated", json!({
                                "success": true,
                                "user": {
                                    "id": user.id.to_string(),
                                    "username": user.username,
                                    "rating": user.rating
                                }
                            }));
                        } else {
                            let _ = socket.emit("authentication_error", json!({
                                "error": "사용자를 찾을 수 없습니다"
                            }));
                        }
                    }
                    Err(_) => {
                        let _ = socket.emit("authentication_error", json!({
                            "error": "유효하지 않은 토큰입니다"
                        }));
                    }
                }
            }
        }
    });

    // 연결 해제 처리
    socket.on_disconnect(move |socket: socketioxide::extract::SocketRef| {
        let state = state.clone();
        async move {
            state.websocket_service.disconnect_user(&socket.id.to_string()).await;
        }
    });

    // 핑/퐁 처리
    socket.on("ping", |socket: socketioxide::extract::SocketRef| {
        async move {
            let _ = socket.emit("pong", ());
        }
    });
}

#[derive(serde::Deserialize)]
struct AuthenticateData {
    token: String,
}
