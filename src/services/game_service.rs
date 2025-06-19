// src/services/game_service.rs
use std::collections::HashMap;
use std::sync::Arc;
use tokio::sync::RwLock;
use uuid::Uuid;
use chrono::Utc;
use crate::models::*;
use super::WebSocketService;

#[derive(Clone)]
pub struct GameService {
    pub sessions: Arc<RwLock<HashMap<Uuid, GameSession>>>,
    websocket_service: WebSocketService,
}

impl GameService {
    pub fn new(websocket_service: WebSocketService) -> Self {
        Self {
            sessions: Arc::new(RwLock::new(HashMap::new())),
            websocket_service,
        }
    }

    // 새 게임 세션 생성
    pub async fn create_game(&self, creator_id: Uuid, game_mode: GameMode) -> Result<Uuid> {
        let session = GameSession::new(game_mode.clone(), creator_id);
        let game_id = session.id;

        let mut sessions = self.sessions.write().await;
        sessions.insert(game_id, session);

        // 게임 룸에 참가
        self.websocket_service.join_game_room(creator_id, game_id).await;

        println!("🎮 새 게임 세션 생성: {} (모드: {:?})", game_id, game_mode);
        Ok(game_id)
    }

    // 게임에 플레이어 추가
    pub async fn join_game(&self, game_id: Uuid, player_id: Uuid, player_info: PlayerInfo) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        session.add_player(player_id, player_info.clone())
            .map_err(|e| TetrisError::Game(e))?;

        // 게임 룸에 참가
        self.websocket_service.join_game_room(player_id, game_id).await;

        // 플레이어 참가 알림
        let message = SocketMessage::PlayerJoined(PlayerJoinedMessage {
            game_id: game_id.to_string(),
            room_id: session.room_id.clone(),
            player: player_info,
            total_players: session.players.len(),
            max_players: match session.game_mode {
                GameMode::SinglePlayer => 1,
                GameMode::OneVsOne => 2,
                GameMode::TwoVsTwo => 4,
            },
        });

        self.websocket_service.send_to_game(game_id, message).await;

        println!("👥 플레이어 게임 참가: {} -> {}", player_id, game_id);
        Ok(())
    }

    // 게임 시작
    pub async fn start_game(&self, game_id: Uuid) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        session.start_game()
            .map_err(|e| TetrisError::Game(e))?;

        // 게임 시작 알림
        let players: Vec<PlayerInfo> = session.player_info.values()
            .map(|info| PlayerInfo {
                id: info.user_id.to_string(),
                username: info.username.clone(),
                avatar_path: info.avatar_path.clone(),
                rating: Some(info.rating),
                is_online: true,
                status: PlayerStatus::InGame,
            })
            .collect();

        let message = SocketMessage::GameStarted(GameStartedMessage {
            game_id: game_id.to_string(),
            room_id: session.room_id.clone(),
            game_mode: session.game_mode.clone(),
            players,
            start_time: session.started_at.unwrap_or_else(Utc::now),
            countdown: None,
        });

        self.websocket_service.send_to_game(game_id, message).await;

        println!("🚀 게임 시작: {}", game_id);
        Ok(())
    }

    // 플레이어 액션 처리
    pub async fn handle_player_action(
        &self,
        game_id: Uuid,
        player_id: Uuid,
        action: PlayerAction
    ) -> Result<bool> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        let result = session.handle_player_action(player_id, action.clone())
            .map_err(|e| TetrisError::Game(e))?;

        // 액션 결과 브로드캐스트
        let message = SocketMessage::PlayerAction(PlayerActionMessage {
            game_id: game_id.to_string(),
            player_id: player_id.to_string(),
            action,
            timestamp: Utc::now(),
            success: result,
        });

        self.websocket_service.send_to_game(game_id, message).await;

        // 게임 상태 업데이트 브로드캐스트
        self.broadcast_game_state(game_id, &session).await;

        Ok(result)
    }

    // 게임 상태 브로드캐스트
    async fn broadcast_game_state(&self, game_id: Uuid, session: &GameSession) {
        let mut players = HashMap::new();

        for (&player_id, player_info) in &session.player_info {
            if let Some(board) = session.game_boards.get(&player_id) {
                players.insert(player_id.to_string(), PlayerGameState {
                    user_id: player_id.to_string(),
                    username: player_info.username.clone(),
                    score: board.score,
                    level: board.level,
                    lines_cleared: board.lines_cleared,
                    board: board.clone(),
                    is_alive: player_info.is_alive,
                    last_action: None, // TODO: 마지막 액션 추적
                    combo_count: board.combo_count,
                });
            }
        }

        let spectators: Vec<PlayerInfo> = session.spectators.iter()
            .filter_map(|&spectator_id| {
                // TODO: 관전자 정보 조회
                None
            })
            .collect();

        let message = SocketMessage::GameState(GameStateUpdate {
            game_id: game_id.to_string(),
            status: session.status.clone(),
            players,
            current_turn: session.current_turn.map(|id| id.to_string()),
            timestamp: Utc::now(),
            spectators,
        });

        self.websocket_service.send_to_game(game_id, message).await;
    }

    // 게임 상태 조회
    pub async fn get_game_state(&self, game_id: Uuid) -> Result<GameSession> {
        let sessions = self.sessions.read().await;
        let session = sessions.get(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        Ok(session.clone())
    }

    // 플레이어의 게임 보드 조회
    pub async fn get_player_board(&self, game_id: Uuid, player_id: Uuid) -> Result<GameBoard> {
        let sessions = self.sessions.read().await;
        let session = sessions.get(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        let board = session.game_boards.get(&player_id)
            .ok_or(TetrisError::Game("플레이어의 게임 보드를 찾을 수 없습니다.".to_string()))?;

        Ok(board.clone())
    }

    // 게임에서 플레이어 제거
    pub async fn leave_game(&self, game_id: Uuid, player_id: Uuid) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        let username = session.player_info.get(&player_id)
            .map(|info| info.username.clone())
            .unwrap_or_else(|| "Unknown".to_string());

        session.remove_player(player_id)
            .map_err(|e| TetrisError::Game(e))?;

        // 게임 룸에서 제거
        self.websocket_service.leave_game_room(player_id, game_id).await;

        // 플레이어 퇴장 알림
        let message = SocketMessage::PlayerLeft(PlayerLeftMessage {
            game_id: game_id.to_string(),
            room_id: session.room_id.clone(),
            player_id: player_id.to_string(),
            username,
            remaining_players: session.players.len(),
            reason: PlayerLeftReason::Leave,
        });

        self.websocket_service.send_to_game(game_id, message).await;

        // 게임에 플레이어가 없으면 세션 삭제
        if session.players.is_empty() {
            sessions.remove(&game_id);
            println!("🗑️ 빈 게임 세션 삭제: {}", game_id);
        }

        println!("👋 플레이어 게임 탈퇴: {} <- {}", game_id, player_id);
        Ok(())
    }

    // 매칭 가능한 게임 찾기
    pub async fn find_matchable_game(&self, game_mode: GameMode) -> Option<Uuid> {
        let sessions = self.sessions.read().await;

        for (&game_id, session) in sessions.iter() {
            if session.game_mode == game_mode && session.status == GameStatus::Waiting {
                let max_players = match game_mode {
                    GameMode::SinglePlayer => 1,
                    GameMode::OneVsOne => 2,
                    GameMode::TwoVsTwo => 4,
                };

                if session.players.len() < max_players {
                    return Some(game_id);
                }
            }
        }

        None
    }

    // 게임 정리 (오래된 완료/포기된 게임 제거)
    pub async fn cleanup_old_games(&self, max_age_hours: i64) {
        let mut sessions = self.sessions.write().await;
        let cutoff_time = chrono::Utc::now() - chrono::Duration::hours(max_age_hours);

        let initial_count = sessions.len();
        sessions.retain(|_, session| {
            match session.status {
                GameStatus::Finished => {
                    session.finished_at
                        .map(|finished| finished > cutoff_time)
                        .unwrap_or(false)
                },
                _ => true, // 진행 중인 게임은 유지
            }
        });

        let cleaned_count = initial_count - sessions.len();
        if cleaned_count > 0 {
            println!("🧹 오래된 게임 세션 {}개 정리됨", cleaned_count);
        }
    }

    // 게임 종료 처리
    pub async fn finish_game(&self, game_id: Uuid, winner: Option<Uuid>) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        if let Some(session) = sessions.get_mut(&game_id) {
            session.finish_game(winner);

            // 게임 종료 알림
            let final_scores: HashMap<String, PlayerFinalScore> = session.player_info.iter()
                .map(|(&player_id, info)| {
                    let board = session.game_boards.get(&player_id);
                    (player_id.to_string(), PlayerFinalScore {
                        score: board.map(|b| b.score).unwrap_or(0),
                        lines_cleared: board.map(|b| b.lines_cleared).unwrap_or(0),
                        level_reached: board.map(|b| b.level).unwrap_or(1),
                        placement: info.placement.unwrap_or(999),
                    })
                })
                .collect();

            let winner_info = winner.and_then(|id| {
                session.player_info.get(&id).map(|info| PlayerInfo {
                    id: id.to_string(),
                    username: info.username.clone(),
                    avatar_path: info.avatar_path.clone(),
                    rating: Some(info.rating),
                    is_online: true,
                    status: PlayerStatus::Online,
                })
            });

            let message = SocketMessage::GameEnded(GameEndedMessage {
                game_id: game_id.to_string(),
                room_id: session.room_id.clone(),
                winner: winner_info,
                final_scores,
                end_time: session.finished_at.unwrap_or_else(Utc::now),
                game_duration: session.get_duration()
                    .map(|d| d.num_seconds() as u64)
                    .unwrap_or(0),
            });

            self.websocket_service.send_to_game(game_id, message).await;
        }

        Ok(())
    }

    // 관전자 추가
    pub async fn add_spectator(&self, game_id: Uuid, spectator_id: Uuid) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        session.add_spectator(spectator_id)
            .map_err(|e| TetrisError::Game(e))?;

        // 게임 룸에 참가
        self.websocket_service.join_game_room(spectator_id, game_id).await;

        println!("👁️ 관전자 추가: {} -> {}", spectator_id, game_id);
        Ok(())
    }

    // 관전자 제거
    pub async fn remove_spectator(&self, game_id: Uuid, spectator_id: Uuid) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        session.remove_spectator(spectator_id)
            .map_err(|e| TetrisError::Game(e))?;

        // 게임 룸에서 제거
        self.websocket_service.leave_game_room(spectator_id, game_id).await;

        println!("👁️ 관전자 제거: {} <- {}", spectator_id, game_id);
        Ok(())
    }

    // 게임 일시정지
    pub async fn pause_game(&self, game_id: Uuid) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        session.pause_game()
            .map_err(|e| TetrisError::Game(e))?;

        // 일시정지 알림
        let message = SocketMessage::GameState(GameStateUpdate {
            game_id: game_id.to_string(),
            status: session.status.clone(),
            players: HashMap::new(), // 간단한 상태만 전송
            current_turn: session.current_turn.map(|id| id.to_string()),
            timestamp: Utc::now(),
            spectators: vec![],
        });

        self.websocket_service.send_to_game(game_id, message).await;

        println!("⏸️ 게임 일시정지: {}", game_id);
        Ok(())
    }

    // 게임 재개
    pub async fn resume_game(&self, game_id: Uuid) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        session.resume_game()
            .map_err(|e| TetrisError::Game(e))?;

        // 재개 알림
        let message = SocketMessage::GameState(GameStateUpdate {
            game_id: game_id.to_string(),
            status: session.status.clone(),
            players: HashMap::new(), // 간단한 상태만 전송
            current_turn: session.current_turn.map(|id| id.to_string()),
            timestamp: Utc::now(),
            spectators: vec![],
        });

        self.websocket_service.send_to_game(game_id, message).await;

        println!("▶️ 게임 재개: {}", game_id);
        Ok(())
    }

    // 플레이어 준비 상태 설정
    pub async fn set_player_ready(&self, game_id: Uuid, player_id: Uuid, ready: bool) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        session.set_player_ready(player_id, ready)
            .map_err(|e| TetrisError::Game(e))?;

        // 준비 상태 알림
        // TODO: 준비 상태 변경 메시지 전송

        // 모든 플레이어가 준비되면 자동 시작
        if session.all_players_ready() && session.status == GameStatus::Waiting {
            session.start_countdown(3); // 3초 카운트다운
        }

        Ok(())
    }

    // 카운트다운 시작
    pub async fn start_countdown(&self, game_id: Uuid, duration_seconds: u32) -> Result<()> {
        let mut sessions = self.sessions.write().await;
        let session = sessions.get_mut(&game_id)
            .ok_or(TetrisError::GameNotFound)?;

        session.start_countdown(duration_seconds);

        // 카운트다운 알림
        let message = SocketMessage::GameStarted(GameStartedMessage {
            game_id: game_id.to_string(),
            room_id: session.room_id.clone(),
            game_mode: session.game_mode.clone(),
            players: session.player_info.values()
                .map(|info| PlayerInfo {
                    id: info.user_id.to_string(),
                    username: info.username.clone(),
                    avatar_path: info.avatar_path.clone(),
                    rating: Some(info.rating),
                    is_online: true,
                    status: PlayerStatus::InGame,
                })
                .collect(),
            start_time: Utc::now(),
            countdown: Some(duration_seconds),
        });

        self.websocket_service.send_to_game(game_id, message).await;

        // 카운트다운 후 자동 시작 (실제 구현 시 타이머 필요)
        // TODO: 타이머 구현

        println!("⏰ 카운트다운 시작: {} ({}초)", game_id, duration_seconds);
        Ok(())
    }

    // 게임 통계 조회
    pub async fn get_game_stats(&self) -> serde_json::Value {
        let sessions = self.sessions.read().await;
        
        let total_games = sessions.len();
        let active_games = sessions.values()
            .filter(|s| s.status == GameStatus::Playing || s.status == GameStatus::Waiting)
            .count();
        let finished_games = sessions.values()
            .filter(|s| s.status == GameStatus::Finished)
            .count();
        let total_players: usize = sessions.values()
            .map(|s| s.players.len())
            .sum();
        let total_spectators: usize = sessions.values()
            .map(|s| s.spectators.len())
            .sum();

        serde_json::json!({
            "total_games": total_games,
            "active_games": active_games,
            "finished_games": finished_games,
            "total_players": total_players,
            "total_spectators": total_spectators
        })
    }

    // AI 봇 추가 (미래 구현)
    pub async fn add_ai_bot(&self, game_id: Uuid, difficulty: u8) -> Result<Uuid> {
        // TODO: AI 봇 구현
        Err(TetrisError::Game("AI 봇 기능은 아직 구현되지 않았습니다.".to_string()))
    }

    // 토너먼트 생성 (미래 구현)
    pub async fn create_tournament(&self, name: String, max_participants: u32) -> Result<Uuid> {
        // TODO: 토너먼트 시스템 구현
        Err(TetrisError::Game("토너먼트 기능은 아직 구현되지 않았습니다.".to_string()))
    }
}
