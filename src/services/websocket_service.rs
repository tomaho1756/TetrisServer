// src/services/websocket_service.rs
use socketioxide::{SocketIo, extract::SocketRef};
use dashmap::DashMap;
use std::sync::Arc;
use uuid::Uuid;
use chrono::Utc;
use crate::models::*;

#[derive(Clone)]
pub struct WebSocketService {
    io: SocketIo,
    connected_users: Arc<DashMap<String, OnlineUser>>, // socket_id -> OnlineUser
    user_sockets: Arc<DashMap<Uuid, String>>, // user_id -> socket_id
    room_users: Arc<DashMap<String, Vec<Uuid>>>, // room_id -> Vec<user_id>
    game_users: Arc<DashMap<Uuid, Vec<Uuid>>>, // game_id -> Vec<user_id>
}

impl WebSocketService {
    pub fn new(io: SocketIo) -> Self {
        Self {
            io,
            connected_users: Arc::new(DashMap::new()),
            user_sockets: Arc::new(DashMap::new()),
            room_users: Arc::new(DashMap::new()),
            game_users: Arc::new(DashMap::new()),
        }
    }

    // 사용자 연결
    pub async fn connect_user(&self, socket_id: String, user: &User) {
        let online_user = OnlineUser::new(user, socket_id.clone());

        // 기존 연결이 있다면 정리
        if let Some(old_socket_id) = self.user_sockets.get(&user.id) {
            self.disconnect_user_internal(&*old_socket_id, false).await;
        }

        self.connected_users.insert(socket_id.clone(), online_user.clone());
        self.user_sockets.insert(user.id, socket_id.clone());

        // 연결 알림 브로드캐스트
        let message = SocketMessage::UserConnected(UserConnectedMessage {
            user: PlayerInfo {
                id: user.id.to_string(),
                username: user.username.clone(),
                avatar_path: user.avatar_path.clone(),
                rating: Some(user.rating),
                is_online: true,
                status: PlayerStatus::Online,
            },
            total_online: self.connected_users.len(),
        });

        self.broadcast_to_all(message).await;

        println!("👤 사용자 연결: {} ({}) - 총 {}명 온라인",
                 user.username, socket_id, self.connected_users.len());
    }

    // 사용자 연결 해제
    pub async fn disconnect_user(&self, socket_id: &str) {
        self.disconnect_user_internal(socket_id, true).await;
    }

    // 내부 연결 해제 처리
    async fn disconnect_user_internal(&self, socket_id: &str, broadcast: bool) {
        if let Some((_, online_user)) = self.connected_users.remove(socket_id) {
            self.user_sockets.remove(&online_user.user_id);

            // 모든 방과 게임에서 제거
            self.cleanup_user_from_rooms_and_games(online_user.user_id).await;

            if broadcast {
                // 연결 해제 알림 브로드캐스트
                let message = SocketMessage::UserDisconnected(UserDisconnectedMessage {
                    user_id: online_user.user_id.to_string(),
                    username: online_user.username.clone(),
                    total_online: self.connected_users.len(),
                });

                self.broadcast_to_all(message).await;
            }

            println!("👋 사용자 연결 해제: {} ({}) - 총 {}명 온라인",
                     online_user.username, socket_id, self.connected_users.len());
        }
    }

    // 사용자를 방과 게임에서 정리
    async fn cleanup_user_from_rooms_and_games(&self, user_id: Uuid) {
        // 방에서 제거
        let mut rooms_to_clean = Vec::new();
        for mut entry in self.room_users.iter_mut() {
            entry.value_mut().retain(|&id| id != user_id);
            if entry.value().is_empty() {
                rooms_to_clean.push(entry.key().clone());
            }
        }

        for room_id in rooms_to_clean {
            self.room_users.remove(&room_id);
        }

        // 게임에서 제거
        let mut games_to_clean = Vec::new();
        for mut entry in self.game_users.iter_mut() {
            entry.value_mut().retain(|&id| id != user_id);
            if entry.value().is_empty() {
                games_to_clean.push(*entry.key());
            }
        }

        for game_id in games_to_clean {
            self.game_users.remove(&game_id);
        }
    }

    // 특정 사용자에게 메시지 전송
    pub async fn send_to_user(&self, user_id: Uuid, message: SocketMessage) {
        if let Some(socket_id) = self.user_sockets.get(&user_id) {
            if let Err(e) = self.io.to(&*socket_id).emit("message", &message) {
                println!("❌ 메시지 전송 실패 ({}): {:?}", socket_id, e);
            }
        }
    }

    // 특정 소켓에 메시지 전송
    pub async fn send_to_socket(&self, socket_id: &str, message: SocketMessage) {
        if let Err(e) = self.io.to(socket_id).emit("message", &message) {
            println!("❌ 메시지 전송 실패 ({}): {:?}", socket_id, e);
        }
    }

    // 방에 있는 모든 사용자에게 메시지 전송
    pub async fn send_to_room(&self, room_id: &str, message: SocketMessage) {
        if let Some(users) = self.room_users.get(room_id) {
            for &user_id in users.iter() {
                self.send_to_user(user_id, message.clone()).await;
            }
        }
    }

    // 게임에 참가한 모든 사용자에게 메시지 전송
    pub async fn send_to_game(&self, game_id: Uuid, message: SocketMessage) {
        if let Some(users) = self.game_users.get(&game_id) {
            for &user_id in users.iter() {
                self.send_to_user(user_id, message.clone()).await;
            }
        }
    }

    // 모든 연결된 사용자에게 브로드캐스트
    pub async fn broadcast_to_all(&self, message: SocketMessage) {
        for user in self.connected_users.iter() {
            if let Err(e) = self.io.to(user.key()).emit("message", &message) {
                println!("❌ 브로드캐스트 실패 ({}): {:?}", user.key(), e);
            }
        }
    }

    // 사용자를 방에 참가시키기
    pub async fn join_room(&self, user_id: Uuid, room_id: &str) {
        // 방 사용자 목록에 추가
        self.room_users.entry(room_id.to_string())
            .or_insert_with(Vec::new)
            .push(user_id);

        // 사용자 상태 업데이트
        if let Some(socket_id) = self.user_sockets.get(&user_id) {
            if let Some(mut user) = self.connected_users.get_mut(&*socket_id) {
                user.current_room_id = Some(room_id.to_string());
                user.status = PlayerStatus::InRoom;
                user.update_activity();
            }
        }

        println!("🏠 사용자 방 참가: {} -> {}", user_id, room_id);
    }

    // 사용자를 방에서 제거
    pub async fn leave_room(&self, user_id: Uuid, room_id: &str) {
        // 방 사용자 목록에서 제거
        if let Some(mut users) = self.room_users.get_mut(room_id) {
            users.retain(|&id| id != user_id);
            if users.is_empty() {
                drop(users);
                self.room_users.remove(room_id);
            }
        }

        // 사용자 상태 업데이트
        if let Some(socket_id) = self.user_sockets.get(&user_id) {
            if let Some(mut user) = self.connected_users.get_mut(&*socket_id) {
                user.current_room_id = None;
                user.status = PlayerStatus::Online;
                user.update_activity();
            }
        }

        println!("🚪 사용자 방 떠남: {} <- {}", room_id, user_id);
    }

    // 사용자를 게임 룸에 참가시키기
    pub async fn join_game_room(&self, user_id: Uuid, game_id: Uuid) {
        // 게임 사용자 목록에 추가
        self.game_users.entry(game_id)
            .or_insert_with(Vec::new)
            .push(user_id);

        // 사용자 상태 업데이트
        if let Some(socket_id) = self.user_sockets.get(&user_id) {
            if let Some(mut user) = self.connected_users.get_mut(&*socket_id) {
                user.current_game_id = Some(game_id.to_string());
                user.status = PlayerStatus::InGame;
                user.update_activity();
            }
        }

        println!("🎮 사용자 게임 참가: {} -> {}", user_id, game_id);
    }

    // 사용자를 게임 룸에서 제거
    pub async fn leave_game_room(&self, user_id: Uuid, game_id: Uuid) {
        // 게임 사용자 목록에서 제거
        if let Some(mut users) = self.game_users.get_mut(&game_id) {
            users.retain(|&id| id != user_id);
            if users.is_empty() {
                drop(users);
                self.game_users.remove(&game_id);
            }
        }

        // 사용자 상태 업데이트
        if let Some(socket_id) = self.user_sockets.get(&user_id) {
            if let Some(mut user) = self.connected_users.get_mut(&*socket_id) {
                user.current_game_id = None;
                // 방에 있으면 InRoom, 없으면 Online
                user.status = if user.current_room_id.is_some() {
                    PlayerStatus::InRoom
                } else {
                    PlayerStatus::Online
                };
                user.update_activity();
            }
        }

        println!("🎮 사용자 게임 떠남: {} <- {}", game_id, user_id);
    }

    // 온라인 사용자 목록 조회
    pub fn get_online_users(&self) -> Vec<OnlineUser> {
        self.connected_users.iter().map(|entry| entry.value().clone()).collect()
    }

    // 특정 방의 사용자 목록 조회
    pub fn get_room_users(&self, room_id: &str) -> Vec<Uuid> {
        self.room_users.get(room_id)
            .map(|users| users.clone())
            .unwrap_or_default()
    }

    // 특정 게임의 사용자 목록 조회
    pub fn get_game_users(&self, game_id: Uuid) -> Vec<Uuid> {
        self.game_users.get(&game_id)
            .map(|users| users.clone())
            .unwrap_or_default()
    }

    // 사용자가 온라인인지 확인
    pub fn is_user_online(&self, user_id: Uuid) -> bool {
        self.user_sockets.contains_key(&user_id)
    }

    // 사용자 상태 업데이트
    pub async fn update_user_status(&self, user_id: Uuid, status: PlayerStatus) {
        if let Some(socket_id) = self.user_sockets.get(&user_id) {
            if let Some(mut online_user) = self.connected_users.get_mut(&*socket_id) {
                online_user.status = status;
                online_user.update_activity();
            }
        }
    }

    // 사용자 활동 업데이트
    pub async fn update_user_activity(&self, socket_id: &str) {
        if let Some(mut online_user) = self.connected_users.get_mut(socket_id) {
            online_user.update_activity();
        }
    }

    // 비활성 사용자 정리
    pub async fn cleanup_inactive_users(&self) {
        let mut to_remove = Vec::new();

        for entry in self.connected_users.iter() {
            if !entry.value().is_active() {
                to_remove.push(entry.key().clone());
            }
        }

        for socket_id in to_remove {
            self.disconnect_user(&socket_id).await;
        }
    }

    // 사용자에게 핑 전송
    pub async fn ping_user(&self, user_id: Uuid) {
        let message = SocketMessage::Ping;
        self.send_to_user(user_id, message).await;
    }

    // 모든 사용자에게 핑 전송
    pub async fn ping_all_users(&self) {
        let message = SocketMessage::Ping;
        self.broadcast_to_all(message).await;
    }

    // 사용자별 지연시간 측정
    pub async fn measure_user_latency(&self, user_id: Uuid) -> Option<u64> {
        // TODO: 핑-퐁을 통한 지연시간 측정 구현
        None
    }

    // 방 통계 조회
    pub fn get_room_stats(&self, room_id: &str) -> Option<RoomConnectionStats> {
        if let Some(users) = self.room_users.get(room_id) {
            let user_count = users.len();
            let active_users = users.iter()
                .filter(|&&user_id| {
                    if let Some(socket_id) = self.user_sockets.get(&user_id) {
                        self.connected_users.get(&*socket_id)
                            .map(|user| user.is_active())
                            .unwrap_or(false)
                    } else {
                        false
                    }
                })
                .count();

            Some(RoomConnectionStats {
                room_id: room_id.to_string(),
                total_users: user_count,
                active_users,
                average_latency: 0, // TODO: 구현
            })
        } else {
            None
        }
    }

    // 게임 통계 조회
    pub fn get_game_stats(&self, game_id: Uuid) -> Option<GameConnectionStats> {
        if let Some(users) = self.game_users.get(&game_id) {
            let user_count = users.len();
            let active_users = users.iter()
                .filter(|&&user_id| {
                    if let Some(socket_id) = self.user_sockets.get(&user_id) {
                        self.connected_users.get(&*socket_id)
                            .map(|user| user.is_active())
                            .unwrap_or(false)
                    } else {
                        false
                    }
                })
                .count();

            Some(GameConnectionStats {
                game_id,
                total_users: user_count,
                active_users,
                average_latency: 0, // TODO: 구현
            })
        } else {
            None
        }
    }

    // 전체 연결 통계
    pub fn get_connection_stats(&self) -> ConnectionStats {
        let total_connections = self.connected_users.len();
        let active_connections = self.connected_users.iter()
            .filter(|entry| entry.value().is_active())
            .count();

        let total_rooms = self.room_users.len();
        let total_games = self.game_users.len();

        ConnectionStats {
            total_connections,
            active_connections,
            total_rooms,
            total_games,
            uptime: chrono::Utc::now(), // TODO: 서버 시작 시간부터 계산
        }
    }

    // 특정 조건의 사용자들에게 메시지 전송
    pub async fn broadcast_to_status(&self, status: PlayerStatus, message: SocketMessage) {
        for entry in self.connected_users.iter() {
            if entry.value().status == status {
                if let Err(e) = self.io.to(entry.key()).emit("message", &message) {
                    println!("❌ 상태별 브로드캐스트 실패 ({}): {:?}", entry.key(), e);
                }
            }
        }
    }

    // 관리자에게만 메시지 전송
    pub async fn broadcast_to_admins(&self, message: SocketMessage) {
        // TODO: 관리자 권한 확인 후 전송
        self.broadcast_to_all(message).await;
    }
}

// 연결 통계 구조체들
#[derive(Debug, Clone, serde::Serialize)]
pub struct ConnectionStats {
    pub total_connections: usize,
    pub active_connections: usize,
    pub total_rooms: usize,
    pub total_games: usize,
    pub uptime: chrono::DateTime<chrono::Utc>,
}

#[derive(Debug, Clone, serde::Serialize)]
pub struct RoomConnectionStats {
    pub room_id: String,
    pub total_users: usize,
    pub active_users: usize,
    pub average_latency: u64,
}

#[derive(Debug, Clone, serde::Serialize)]
pub struct GameConnectionStats {
    pub game_id: Uuid,
    pub total_users: usize,
    pub active_users: usize,
    pub average_latency: u64,
}