// src/main.rs
use axum::{
    extract::{Path, State},
    http::{HeaderValue, Method, StatusCode},
    response::Json,
    routing::{get, post, delete},
    Router,
};
use socketioxide::{extract::SocketRef, SocketIo};
use std::sync::Arc;
use tower::ServiceBuilder;
use tower_http::cors::{Any, CorsLayer};
use tracing::{info, Level};
use tracing_subscriber;

mod handlers;
mod services;
mod database;
mod models;

use models::*;
use handlers::*;
use services::*;
use database::Database;

// 애플리케이션 상태
#[derive(Clone)]
pub struct AppState {
    pub game_service: GameService,
    pub user_service: UserService,
    pub room_service: RoomService,
    pub websocket_service: WebSocketService,
    pub db: Database,
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 로깅 초기화
    tracing_subscriber::fmt()
        .with_max_level(Level::INFO)
        .init();

    // 환경 변수 로드
    dotenv::dotenv().ok();

    println!("🎮 테트리스 멀티플레이어 서버 초기화 중...");

    // 데이터베이스 초기화
    let db = Database::new().await?;
    db.migrate().await?;

    // WebSocket 서비스 초기화
    let (layer, io) = SocketIo::new_layer();
    let websocket_service = WebSocketService::new(io.clone());

    // 서비스 초기화
    let game_service = GameService::new(websocket_service.clone());
    let user_service = UserService::new(db.clone());
    let room_service = RoomService::new(websocket_service.clone());

    // 애플리케이션 상태
    let app_state = AppState {
        game_service: game_service.clone(),
        user_service,
        room_service: room_service.clone(),
        websocket_service: websocket_service.clone(),
        db,
    };

    // WebSocket 이벤트 핸들러 등록
    io.ns("/", |socket: SocketRef| {
        websocket_handler(socket, app_state.clone())
    });

    // CORS 설정
    let cors = CorsLayer::new()
        .allow_origin(Any)
        .allow_headers(Any)
        .allow_methods([Method::GET, Method::POST, Method::PUT, Method::DELETE]);

    // 라우터 설정
    let app = Router::new()
        // 기본 라우트
        .route("/", get(health_check))

        // 인증 API
        .route("/api/auth/register", post(register_user))
        .route("/api/auth/login", post(login_user))

        // 게임 API
        .route("/api/game/start", post(start_single_game))
        .route("/api/game/:game_id/move", post(make_move))
        .route("/api/game/:game_id", get(get_game_state))
        .route("/api/game/:game_id/leave", post(leave_game))

        // 사용자 API
        .route("/api/users/:user_id/stats", get(get_user_stats))
        .route("/api/leaderboard", get(get_leaderboard))
        .route("/api/game/stats", post(save_game_stats))

        // 매칭 API
        .route("/api/matchmaking/request", post(request_matching))
        .route("/api/matchmaking/cancel", delete(cancel_matching))

        // 방 관리 API
        .route("/api/rooms", get(list_rooms))
        .route("/api/rooms", post(create_room))
        .route("/api/rooms/:room_id", get(get_room))
        .route("/api/rooms/:room_id/join", post(join_room))
        .route("/api/rooms/:room_id/leave", post(leave_room))
        .route("/api/rooms/:room_id/start", post(start_room_game))
        .route("/api/rooms/join-by-code", post(join_room_by_code))

        // 채팅 API
        .route("/api/chat/:room_id/messages", get(get_chat_messages))
        .route("/api/chat/:room_id/send", post(send_chat_message))

        // 친구 시스템 API (미래 구현)
        .route("/api/friends", get(get_friends))
        .route("/api/friends/requests", get(get_friend_requests))
        .route("/api/friends/add", post(send_friend_request))
        .route("/api/friends/:friend_id/accept", post(accept_friend_request))
        .route("/api/friends/:friend_id/decline", post(decline_friend_request))
        .route("/api/friends/:friend_id/remove", delete(remove_friend))

        // 관리자 API (미래 구현)
        .route("/api/admin/stats", get(get_admin_stats))
        .route("/api/admin/users", get(get_all_users))
        .route("/api/admin/games", get(get_all_games))
        .route("/api/admin/ban/:user_id", post(ban_user))

        .layer(
            ServiceBuilder::new()
                .layer(cors)
                .layer(layer)
        )
        .with_state(app_state);

    // 정기적인 정리 작업 시작
    start_cleanup_tasks(game_service, room_service).await;

    // 서버 시작
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await?;
    info!("🎮 테트리스 멀티플레이어 서버가 http://0.0.0.0:3000 에서 실행 중입니다!");
    info!("🔌 WebSocket 엔드포인트: ws://0.0.0.0:3000/socket.io/");

    axum::serve(listener, app).await?;

    Ok(())
}

async fn health_check() -> &'static str {
    "🎮 테트리스 멀티플레이어 서버가 정상 작동 중입니다!"
}

// 정리 작업 시작
async fn start_cleanup_tasks(game_service: GameService, room_service: RoomService) {
    // 게임 세션 정리 (1시간마다)
    let game_service_cleanup = game_service.clone();
    tokio::spawn(async move {
        let mut interval = tokio::time::interval(std::time::Duration::from_secs(3600));
        loop {
            interval.tick().await;
            game_service_cleanup.cleanup_old_games(24).await;
        }
    });

    // 빈 방 정리 (10분마다)
    let room_service_cleanup = room_service.clone();
    tokio::spawn(async move {
        let mut interval = tokio::time::interval(std::time::Duration::from_secs(600));
        loop {
            interval.tick().await;
            room_service_cleanup.cleanup_empty_rooms().await;
        }
    });

    info!("🧹 정리 작업이 시작되었습니다.");
}