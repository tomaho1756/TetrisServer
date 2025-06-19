// src/models/mod.rs
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use uuid::Uuid;
use chrono::{DateTime, Utc};

pub mod tetromino;
pub mod game_board;
pub mod user;
pub mod room;
mod game_sessions;

pub use tetromino::*;
pub use game_board::*;
pub use user::*;
pub use game_sessions::*;
pub use room::*;

// 게임 타입 열거형
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum GameMode {
    SinglePlayer,
    OneVsOne,
    TwoVsTwo,
}

// 게임 상태 열거형
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum GameStatus {
    Waiting,
    Playing,
    Paused,
    Finished,
}

// 플레이어 액션 열거형
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum PlayerAction {
    MoveLeft,
    MoveRight,
    MoveDown,
    Rotate,
    HardDrop,
    Hold,
}

// WebSocket 메시지 타입
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "type", content = "data")]
pub enum SocketMessage {
    // 게임 관련
    GameState(GameStateUpdate),
    PlayerJoined(PlayerJoinedMessage),
    PlayerLeft(PlayerLeftMessage),
    GameStarted(GameStartedMessage),
    GameEnded(GameEndedMessage),
    PlayerAction(PlayerActionMessage),
    LineCleared(LineClearedMessage),

    // 채팅 관련
    ChatMessage(ChatMessageData),
    UserTyping(TypingMessage),

    // 방 관련
    RoomCreated(RoomData),
    RoomUpdated(RoomData),
    RoomJoined(RoomJoinedMessage),
    RoomLeft(RoomLeftMessage),
    RoomDeleted(RoomDeletedMessage),

    // 매칭 관련
    MatchFound(MatchFoundMessage),
    MatchCancelled,

    // 시스템 메시지
    UserConnected(UserConnectedMessage),
    UserDisconnected(UserDisconnectedMessage),

    // 에러
    Error(ErrorMessage),

    // 핑/퐁
    Ping,
    Pong,
}

// 게임 상태 업데이트 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GameStateUpdate {
    pub game_id: String,
    pub status: GameStatus,
    pub players: HashMap<String, PlayerGameState>,
    pub current_turn: Option<String>,
    pub timestamp: DateTime<Utc>,
    pub spectators: Vec<PlayerInfo>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlayerGameState {
    pub user_id: String,
    pub username: String,
    pub score: u32,
    pub level: u32,
    pub lines_cleared: u32,
    pub board: GameBoard,
    pub is_alive: bool,
    pub last_action: Option<PlayerAction>,
    pub combo_count: u32,
}

// 플레이어 참가 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlayerJoinedMessage {
    pub game_id: String,
    pub room_id: Option<String>,
    pub player: PlayerInfo,
    pub total_players: usize,
    pub max_players: usize,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlayerLeftMessage {
    pub game_id: String,
    pub room_id: Option<String>,
    pub player_id: String,
    pub username: String,
    pub remaining_players: usize,
    pub reason: PlayerLeftReason,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum PlayerLeftReason {
    Disconnect,
    Leave,
    Kick,
    Ban,
    GameOver,
}

// 게임 시작 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GameStartedMessage {
    pub game_id: String,
    pub room_id: Option<String>,
    pub game_mode: GameMode,
    pub players: Vec<PlayerInfo>,
    pub start_time: DateTime<Utc>,
    pub countdown: Option<u32>,
}

// 게임 종료 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GameEndedMessage {
    pub game_id: String,
    pub room_id: Option<String>,
    pub winner: Option<PlayerInfo>,
    pub final_scores: HashMap<String, PlayerFinalScore>,
    pub end_time: DateTime<Utc>,
    pub game_duration: u64, // 초
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlayerFinalScore {
    pub score: u32,
    pub lines_cleared: u32,
    pub level_reached: u32,
    pub placement: u32, // 1위, 2위 등
}

// 플레이어 액션 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlayerActionMessage {
    pub game_id: String,
    pub player_id: String,
    pub action: PlayerAction,
    pub timestamp: DateTime<Utc>,
    pub success: bool,
}

// 라인 클리어 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LineClearedMessage {
    pub game_id: String,
    pub player_id: String,
    pub lines_cleared: u32,
    pub is_tetris: bool,
    pub attack_lines: Option<u32>, // 다른 플레이어에게 보낼 공격 라인
}

// 채팅 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ChatMessageData {
    pub id: String,
    pub room_id: Option<String>,
    pub game_id: Option<String>,
    pub sender: PlayerInfo,
    pub message: String,
    pub timestamp: DateTime<Utc>,
    pub message_type: ChatMessageType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ChatMessageType {
    Text,
    System,
    Emoji,
    GameEvent,
    Command,
}

// 타이핑 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TypingMessage {
    pub room_id: Option<String>,
    pub game_id: Option<String>,
    pub user: PlayerInfo,
    pub is_typing: bool,
}

// 방 참가/퇴장 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoomJoinedMessage {
    pub room: RoomData,
    pub player: PlayerInfo,
    pub welcome_message: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoomLeftMessage {
    pub room_id: String,
    pub player_id: String,
    pub username: String,
    pub reason: PlayerLeftReason,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoomDeletedMessage {
    pub room_id: String,
    pub reason: String,
}

// 매칭 발견 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MatchFoundMessage {
    pub game_id: String,
    pub game_mode: GameMode,
    pub players: Vec<PlayerInfo>,
    pub room_code: Option<String>,
    pub estimated_start_time: DateTime<Utc>,
}

// 사용자 연결/해제 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserConnectedMessage {
    pub user: PlayerInfo,
    pub total_online: usize,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserDisconnectedMessage {
    pub user_id: String,
    pub username: String,
    pub total_online: usize,
}

// 에러 메시지
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ErrorMessage {
    pub code: String,
    pub message: String,
    pub details: Option<String>,
}

// 플레이어 정보
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlayerInfo {
    pub id: String,
    pub username: String,
    pub avatar_path: Option<String>,
    pub rating: Option<u32>,
    pub is_online: bool,
    pub status: PlayerStatus,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum PlayerStatus {
    Online,
    InGame,
    InRoom,
    Away,
    Offline,
}

// API 요청/응답 구조체들
#[derive(Debug, Serialize, Deserialize)]
pub struct RegisterRequest {
    pub username: String,
    pub email: String,
    pub password: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct LoginRequest {
    pub email: String,
    pub password: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct AuthResponse {
    pub token: String,
    pub user: User,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct GameMoveRequest {
    pub action: PlayerAction,
    pub player_id: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct StartGameRequest {
    pub player_id: String,
    pub game_mode: GameMode,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct GameStateResponse {
    pub game_id: String,
    pub status: GameStatus,
    pub current_player: Option<String>,
    pub game_board: GameBoard,
    pub score: u32,
    pub level: u32,
    pub lines_cleared: u32,
    pub next_piece: TetrominoType,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct UserStatsResponse {
    pub user_id: String,
    pub username: String,
    pub total_games: u32,
    pub wins: u32,
    pub losses: u32,
    pub highest_score: u32,
    pub total_lines_cleared: u32,
    pub average_score: f32,
}

// 방 생성 요청
#[derive(Debug, Serialize, Deserialize)]
pub struct CreateRoomRequest {
    pub name: String,
    pub game_mode: GameMode,
    pub max_players: u8,
    pub is_private: bool,
    pub password: Option<String>,
    pub description: Option<String>,
}

// 방 참가 요청
#[derive(Debug, Serialize, Deserialize)]
pub struct JoinRoomRequest {
    pub room_code: String,
    pub password: Option<String>,
}

// 채팅 메시지 전송 요청
#[derive(Debug, Serialize, Deserialize)]
pub struct SendChatRequest {
    pub message: String,
    pub message_type: Option<ChatMessageType>,
}

// 친구 요청 관련
#[derive(Debug, Serialize, Deserialize)]
pub struct FriendRequest {
    pub id: String,
    pub from_user: PlayerInfo,
    pub to_user: PlayerInfo,
    pub message: Option<String>,
    pub created_at: DateTime<Utc>,
    pub status: FriendRequestStatus,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FriendRequestStatus {
    Pending,
    Accepted,
    Declined,
    Cancelled,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct SendFriendRequestRequest {
    pub to_user_id: String,
    pub message: Option<String>,
}

// 관리자 통계
#[derive(Debug, Serialize, Deserialize)]
pub struct AdminStats {
    pub total_users: u64,
    pub online_users: u64,
    pub active_games: u64,
    pub total_games_played: u64,
    pub active_rooms: u64,
    pub server_uptime: u64,
    pub top_players: Vec<UserStatsResponse>,
}

// 에러 타입
#[derive(Debug, thiserror::Error)]
pub enum TetrisError {
    #[error("데이터베이스 오류: {0}")]
    Database(#[from] sqlx::Error),

    #[error("인증 오류: {0}")]
    Authentication(String),

    #[error("게임 오류: {0}")]
    Game(String),

    #[error("유효하지 않은 입력: {0}")]
    InvalidInput(String),

    #[error("사용자를 찾을 수 없음")]
    UserNotFound,

    #[error("게임을 찾을 수 없음")]
    GameNotFound,

    #[error("방을 찾을 수 없음")]
    RoomNotFound,

    #[error("권한이 없음")]
    Unauthorized,

    #[error("방이 가득참")]
    RoomFull,

    #[error("잘못된 비밀번호")]
    InvalidPassword,

    #[error("이미 게임 중")]
    AlreadyInGame,

    #[error("이미 방에 있음")]
    AlreadyInRoom,

    #[error("웹소켓 오류: {0}")]
    WebSocket(String),

    #[error("JSON 파싱 오류: {0}")]
    Json(#[from] serde_json::Error),
}

pub type Result<T> = std::result::Result<T, TetrisError>;