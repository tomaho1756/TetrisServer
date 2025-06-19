// src/services/room_service.rs
use std::collections::HashMap;
use std::sync::Arc;
use tokio::sync::RwLock;
use uuid::Uuid;
use chrono::Utc;
use crate::models::*;
use super::WebSocketService;

#[derive(Clone)]
pub struct RoomService {
    rooms: Arc<RwLock<HashMap<String, Room>>>,
    websocket_service: WebSocketService,
}

impl RoomService {
    pub fn new(websocket_service: WebSocketService) -> Self {
        Self {
            rooms: Arc::new(RwLock::new(HashMap::new())),
            websocket_service,
        }
    }

    // 새 방 생성 (요청 기반)
    pub async fn create_room(&self, owner_id: Uuid, request: CreateRoomRequest) -> Result<RoomData> {
        // 사용자 정보 가져오기 (임시로 기본값 사용)
        let owner_info = PlayerInfo {
            id: owner_id.to_string(),
            username: "Player".to_string(), // TODO: 실제 사용자 정보 가져오기
            avatar_path: None,
            rating: Some(1000),
            is_online: true,
            status: PlayerStatus::InRoom,
        };

        let room_id = self.create_room_with_info(
            request.name,
            owner_id,
            owner_info,
            request.game_mode,
            request.max_players,
            request.is_private,
            request.password,
            request.description,
        ).await?;

        let room = self.get_room(&room_id).await?;
        Ok(RoomData {
            room,
            can_join: true,
            can_spectate: true,
            join_error: None,
        })
    }

    // 새 방 생성 (내부용)
    async fn create_room_with_info(
        &self,
        name: String,
        owner_id: Uuid,
        owner_info: PlayerInfo,
        game_mode: GameMode,
        max_players: u8,
        is_private: bool,
        password: Option<String>,
        description: Option<String>,
    ) -> Result<String> {
        let mut room = Room::new(
            name,
            owner_id,
            owner_info.clone(),
            game_mode.clone(),
            max_players,
            is_private,
            password,
        );

        if let Some(desc) = description {
            room.description = Some(desc);
        }

        let room_id = room.id.clone();

        let mut rooms = self.rooms.write().await;
        rooms.insert(room_id.clone(), room.clone());

        // 방장을 방에 참가시키기
        self.websocket_service.join_room(owner_id, &room_id).await;

        // 방 생성 알림
        let message = SocketMessage::RoomCreated(RoomData {
            room: room.clone(),
            can_join: true,
            can_spectate: room.settings.allow_spectators,
            join_error: None,
        });

        self.websocket_service.send_to_user(owner_id, message).await;

        println!("🏠 새 방 생성: {} ({})", room.name, room_id);
        Ok(room_id)
    }

    // 방에 참가 (ID로)
    pub async fn join_room(&self, room_id: &str, player_id: Uuid, password: Option<String>) -> Result<RoomData> {
        // 사용자 정보 가져오기 (임시로 기본값 사용)
        let player_info = PlayerInfo {
            id: player_id.to_string(),
            username: "Player".to_string(), // TODO: 실제 사용자 정보 가져오기
            avatar_path: None,
            rating: Some(1000),
            is_online: true,
            status: PlayerStatus::InRoom,
        };

        self.join_room_with_info(room_id.to_string(), player_id, player_info, password).await?;
        
        let room = self.get_room(room_id).await?;
        Ok(RoomData {
            room,
            can_join: true,
            can_spectate: true,
            join_error: None,
        })
    }

    // 방에 참가 (내부용)
    async fn join_room_with_info(
        &self,
        room_id: String,
        player_id: Uuid,
        player_info: PlayerInfo,
        password: Option<String>,
    ) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        room.add_player(player_id, player_info.clone(), password)
            .map_err(|e| TetrisError::InvalidInput(e))?;

        // WebSocket 방에 참가
        self.websocket_service.join_room(player_id, &room_id).await;

        // 방 참가 알림 (본인에게)
        let join_message = SocketMessage::RoomJoined(RoomJoinedMessage {
            room: RoomData {
                room: room.clone(),
                can_join: true,
                can_spectate: room.settings.allow_spectators,
                join_error: None,
            },
            player: player_info.clone(),
            welcome_message: Some(format!("{}님이 방에 참가했습니다!", player_info.username)),
        });

        self.websocket_service.send_to_user(player_id, join_message).await;

        // 방 업데이트 알림 (방 전체에게)
        let update_message = SocketMessage::RoomUpdated(RoomData {
            room: room.clone(),
            can_join: room.current_players.len() < room.max_players as usize,
            can_spectate: room.settings.allow_spectators,
            join_error: None,
        });

        self.websocket_service.send_to_room(&room_id, update_message).await;

        println!("👥 플레이어 방 참가: {} -> {} ({})", player_info.username, room.name, room_id);
        Ok(())
    }

    // 방 코드로 참가
    pub async fn join_room_by_code(
        &self,
        room_code: &str,
        player_id: Uuid,
        password: Option<String>,
    ) -> Result<RoomData> {
        // 방 코드를 대문자로 변환
        let room_code = room_code.to_uppercase();
        
        // 사용자 정보 가져오기 (임시로 기본값 사용)
        let player_info = PlayerInfo {
            id: player_id.to_string(),
            username: "Player".to_string(), // TODO: 실제 사용자 정보 가져오기
            avatar_path: None,
            rating: Some(1000),
            is_online: true,
            status: PlayerStatus::InRoom,
        };

        self.join_room_with_info(room_code.clone(), player_id, player_info, password).await?;
        
        let room = self.get_room(&room_code).await?;
        Ok(RoomData {
            room,
            can_join: true,
            can_spectate: true,
            join_error: None,
        })
    }

    // 방에서 게임 시작
    pub async fn start_game(&self, room_id: &str, requester_id: Uuid) -> Result<Uuid> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        // 권한 체크 (방장만 시작 가능)
        if room.owner_id != requester_id {
            return Err(TetrisError::Unauthorized);
        }

        // 게임 시작 가능 여부 확인
        if !room.can_start_game() {
            return Err(TetrisError::Game("게임을 시작할 수 없습니다.".to_string()));
        }

        // 게임 ID 생성 (실제로는 GameService에서 생성해야 함)
        let game_id = Uuid::new_v4();
        room.current_game_id = Some(game_id);
        room.status = RoomStatus::InGame;

        println!("🚀 방에서 게임 시작: {} ({})", room.name, room_id);
        Ok(game_id)
    }

    // 관전자로 참가
    pub async fn join_as_spectator(
        &self,
        room_id: String,
        spectator_id: Uuid,
        spectator_info: PlayerInfo,
    ) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        room.add_spectator(spectator_id, spectator_info.clone())
            .map_err(|e| TetrisError::InvalidInput(e))?;

        // WebSocket 방에 참가
        self.websocket_service.join_room(spectator_id, &room_id).await;

        // 관전 참가 알림
        let join_message = SocketMessage::RoomJoined(RoomJoinedMessage {
            room: RoomData {
                room: room.clone(),
                can_join: false,
                can_spectate: true,
                join_error: None,
            },
            player: spectator_info.clone(),
            welcome_message: Some(format!("{}님이 관전을 시작했습니다!", spectator_info.username)),
        });

        self.websocket_service.send_to_user(spectator_id, join_message).await;

        // 방 업데이트 알림
        let update_message = SocketMessage::RoomUpdated(RoomData {
            room: room.clone(),
            can_join: room.current_players.len() < room.max_players as usize,
            can_spectate: room.settings.allow_spectators,
            join_error: None,
        });

        self.websocket_service.send_to_room(&room_id, update_message).await;

        println!("👁️ 관전자 참가: {} -> {} ({})", spectator_info.username, room.name, room_id);
        Ok(())
    }

    // 방에서 나가기
    pub async fn leave_room(&self, room_id: String, player_id: Uuid) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        let username = room.player_info.get(&player_id)
            .map(|info| info.username.clone())
            .unwrap_or_else(|| "Unknown".to_string());

        room.remove_player(player_id)
            .map_err(|e| TetrisError::InvalidInput(e))?;

        // WebSocket 방에서 제거
        self.websocket_service.leave_room(player_id, &room_id).await;

        // 방 떠나기 알림
        let leave_message = SocketMessage::RoomLeft(RoomLeftMessage {
            room_id: room_id.clone(),
            player_id: player_id.to_string(),
            username: username.clone(),
            reason: PlayerLeftReason::Leave,
        });

        self.websocket_service.send_to_room(&room_id, leave_message).await;

        // 방이 비었으면 삭제
        if room.status == RoomStatus::Closed {
            rooms.remove(&room_id);

            let delete_message = SocketMessage::RoomDeleted(RoomDeletedMessage {
                room_id: room_id.clone(),
                reason: "방이 비어서 삭제되었습니다.".to_string(),
            });

            // 모든 사용자에게 방 삭제 알림 (방 목록 갱신용)
            self.websocket_service.broadcast_to_all(delete_message).await;

            println!("🗑️ 빈 방 삭제: {} ({})", room.name, room_id);
        } else {
            // 방 업데이트 알림
            let update_message = SocketMessage::RoomUpdated(RoomData {
                room: room.clone(),
                can_join: room.current_players.len() < room.max_players as usize,
                can_spectate: room.settings.allow_spectators,
                join_error: None,
            });

            self.websocket_service.send_to_room(&room_id, update_message).await;
        }

        println!("👋 플레이어 방 떠남: {} <- {} ({})", username, room.name, room_id);
        Ok(())
    }

    // 플레이어 준비 상태 설정
    pub async fn set_ready(&self, room_id: String, player_id: Uuid, ready: bool) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        room.set_ready(player_id, ready)
            .map_err(|e| TetrisError::InvalidInput(e))?;

        // 방 업데이트 알림
        let update_message = SocketMessage::RoomUpdated(RoomData {
            room: room.clone(),
            can_join: room.current_players.len() < room.max_players as usize,
            can_spectate: room.settings.allow_spectators,
            join_error: None,
        });

        self.websocket_service.send_to_room(&room_id, update_message).await;

        // 자동 시작 체크
        if room.can_start_game() && room.settings.auto_start {
            // 게임 시작 처리는 별도 서비스에서
            println!("🎮 자동 게임 시작 가능: {} ({})", room.name, room_id);
        }

        Ok(())
    }

    // 방 설정 업데이트
    pub async fn update_room_settings(
        &self,
        room_id: String,
        updater_id: Uuid,
        settings: RoomSettings,
    ) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        // 권한 체크
        if let Some(player_info) = room.player_info.get(&updater_id) {
            match player_info.role {
                RoomRole::Owner | RoomRole::Moderator => {},
                _ => return Err(TetrisError::Unauthorized),
            }
        } else {
            return Err(TetrisError::Unauthorized);
        }

        room.settings = settings;
        room.update_activity();

        // 방 업데이트 알림
        let update_message = SocketMessage::RoomUpdated(RoomData {
            room: room.clone(),
            can_join: room.current_players.len() < room.max_players as usize,
            can_spectate: room.settings.allow_spectators,
            join_error: None,
        });

        self.websocket_service.send_to_room(&room_id, update_message).await;

        Ok(())
    }

    // 플레이어 추방
    pub async fn kick_player(
        &self,
        room_id: String,
        kicker_id: Uuid,
        target_id: Uuid,
        ban: bool,
    ) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        let target_username = room.player_info.get(&target_id)
            .map(|info| info.username.clone())
            .unwrap_or_else(|| "Unknown".to_string());

        room.kick_player(kicker_id, target_id, ban)
            .map_err(|e| TetrisError::InvalidInput(e))?;

        // WebSocket 방에서 제거
        self.websocket_service.leave_room(target_id, &room_id).await;

        // 추방 알림
        let kick_message = SocketMessage::RoomLeft(RoomLeftMessage {
            room_id: room_id.clone(),
            player_id: target_id.to_string(),
            username: target_username.clone(),
            reason: if ban { PlayerLeftReason::Ban } else { PlayerLeftReason::Kick },
        });

        self.websocket_service.send_to_room(&room_id, kick_message).await;

        // 추방당한 플레이어에게 개별 알림
        let error_message = SocketMessage::Error(ErrorMessage {
            code: if ban { "BANNED" } else { "KICKED" },
            message: if ban {
                "방에서 추방되었습니다.".to_string()
            } else {
                "방에서 강퇴되었습니다.".to_string()
            },
            details: None,
        });

        self.websocket_service.send_to_user(target_id, error_message).await;

        println!("🚫 플레이어 추방: {} from {} ({})", target_username, room.name, room_id);
        Ok(())
    }

    // 방장 위임
    pub async fn transfer_ownership(
        &self,
        room_id: String,
        current_owner_id: Uuid,
        new_owner_id: Uuid,
    ) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        // 현재 방장인지 확인
        if room.owner_id != current_owner_id {
            return Err(TetrisError::Unauthorized);
        }

        room.transfer_ownership(new_owner_id)
            .map_err(|e| TetrisError::InvalidInput(e))?;

        // 방 업데이트 알림
        let update_message = SocketMessage::RoomUpdated(RoomData {
            room: room.clone(),
            can_join: room.current_players.len() < room.max_players as usize,
            can_spectate: room.settings.allow_spectators,
            join_error: None,
        });

        self.websocket_service.send_to_room(&room_id, update_message).await;

        println!("👑 방장 위임: {} ({})", room.name, room_id);
        Ok(())
    }

    // 채팅 메시지 전송
    pub async fn send_chat_message(
        &self,
        room_id: String,
        sender_id: Uuid,
        message: String,
        message_type: ChatMessageType,
    ) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        // 채팅이 활성화되어 있는지 확인
        if !room.settings.chat_enabled {
            return Err(TetrisError::InvalidInput("채팅이 비활성화되어 있습니다.".to_string()));
        }

        // 발신자 정보 가져오기
        let sender_info = room.player_info.get(&sender_id)
            .ok_or(TetrisError::UserNotFound)?;

        let chat_message = ChatMessageData {
            id: Uuid::new_v4().to_string(),
            room_id: Some(room_id.clone()),
            game_id: room.current_game_id.map(|id| id.to_string()),
            sender: PlayerInfo {
                id: sender_id.to_string(),
                username: sender_info.username.clone(),
                avatar_path: sender_info.avatar_path.clone(),
                rating: Some(sender_info.rating),
                is_online: true,
                status: PlayerStatus::InRoom,
            },
            message,
            timestamp: Utc::now(),
            message_type,
        };

        // 방에 메시지 저장
        room.add_chat_message(chat_message.clone());

        // 채팅 메시지 브로드캐스트
        let socket_message = SocketMessage::ChatMessage(chat_message);
        self.websocket_service.send_to_room(&room_id, socket_message).await;

        Ok(())
    }

    // 방 목록 조회 (페이지네이션)
    pub async fn list_rooms(&self, page: u32, limit: u32) -> Result<Vec<RoomData>> {
        let rooms = self.list_rooms_basic(false, false).await;
        
        let start = (page * limit) as usize;
        let end = start + limit as usize;
        
        let paginated_rooms: Vec<RoomSummary> = rooms
            .into_iter()
            .skip(start)
            .take(limit as usize)
            .collect();

        let mut room_data = Vec::new();
        for summary in paginated_rooms {
            if let Ok(room) = self.get_room(&summary.id).await {
                room_data.push(RoomData {
                    room,
                    can_join: summary.current_players < summary.max_players,
                    can_spectate: true,
                    join_error: None,
                });
            }
        }

        Ok(room_data)
    }

    // 기본 방 목록 조회
    async fn list_rooms_basic(&self, include_private: bool, include_full: bool) -> Vec<RoomSummary> {
        let rooms = self.rooms.read().await;

        rooms.values()
            .filter(|room| {
                // 비공개 방 필터링
                if !include_private && room.is_private {
                    return false;
                }

                // 가득 찬 방 필터링
                if !include_full && room.current_players.len() >= room.max_players as usize {
                    return false;
                }

                // 닫힌 방 제외
                room.status != RoomStatus::Closed
            })
            .map(|room| room.get_summary())
            .collect()
    }

    // 방 정보 조회
    pub async fn get_room(&self, room_id: String) -> Result<Room> {
        let rooms = self.rooms.read().await;
        let room = rooms.get(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        Ok(room.clone())
    }

    // 사용자가 참가한 방 찾기
    pub async fn find_user_room(&self, user_id: Uuid) -> Option<String> {
        let rooms = self.rooms.read().await;

        for (room_id, room) in rooms.iter() {
            if room.current_players.contains(&user_id) || room.spectators.contains(&user_id) {
                return Some(room_id.clone());
            }
        }

        None
    }

    // 빈 방 정리
    pub async fn cleanup_empty_rooms(&self) {
        let mut rooms = self.rooms.write().await;
        let mut to_remove = Vec::new();

        for (room_id, room) in rooms.iter() {
            if room.is_expired() ||
                (room.current_players.is_empty() && room.spectators.is_empty()) ||
                room.status == RoomStatus::Closed {
                to_remove.push(room_id.clone());
            }
        }

        for room_id in &to_remove {
            if let Some(room) = rooms.remove(room_id) {
                // 방 삭제 알림
                let delete_message = SocketMessage::RoomDeleted(RoomDeletedMessage {
                    room_id: room_id.clone(),
                    reason: "방이 만료되어 삭제되었습니다.".to_string(),
                });

                self.websocket_service.broadcast_to_all(delete_message).await;

                println!("🧹 만료된 방 삭제: {} ({})", room.name, room_id);
            }
        }

        if !to_remove.is_empty() {
            println!("🧹 정리된 방 개수: {}", to_remove.len());
        }
    }

    // 팀 재배정 (2v2 모드)
    pub async fn rebalance_teams(&self, room_id: String, requester_id: Uuid) -> Result<()> {
        let mut rooms = self.rooms.write().await;
        let room = rooms.get_mut(&room_id)
            .ok_or(TetrisError::RoomNotFound)?;

        // 권한 체크
        if let Some(player_info) = room.player_info.get(&requester_id) {
            match player_info.role {
                RoomRole::Owner | RoomRole::Moderator => {},
                _ => return Err(TetrisError::Unauthorized),
            }
        } else {
            return Err(TetrisError::Unauthorized);
        }

        room.rebalance_teams()
            .map_err(|e| TetrisError::InvalidInput(e))?;

        // 방 업데이트 알림
        let update_message = SocketMessage::RoomUpdated(RoomData {
            room: room.clone(),
            can_join: room.current_players.len() < room.max_players as usize,
            can_spectate: room.settings.allow_spectators,
            join_error: None,
        });

        self.websocket_service.send_to_room(&room_id, update_message).await;

        println!("⚖️ 팀 재배정: {} ({})", room.name, room_id);
        Ok(())
    }

    // 방 통계 조회
    pub async fn get_room_stats(&self) -> serde_json::Value {
        let rooms = self.rooms.read().await;

        let total_rooms = rooms.len();
        let active_rooms = rooms.values().filter(|r| r.status != RoomStatus::Closed).count();
        let public_rooms = rooms.values().filter(|r| !r.is_private).count();
        let in_game_rooms = rooms.values().filter(|r| r.status == RoomStatus::InGame).count();
        let total_players: usize = rooms.values().map(|r| r.current_players.len()).sum();
        let total_spectators: usize = rooms.values().map(|r| r.spectators.len()).sum();

        serde_json::json!({
            "total_rooms": total_rooms,
            "active_rooms": active_rooms,
            "public_rooms": public_rooms,
            "in_game_rooms": in_game_rooms,
            "total_players": total_players,
            "total_spectators": total_spectators,
        })
    }
}