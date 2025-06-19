// src/models/room.rs
use serde::{Deserialize, Serialize};
use uuid::Uuid;
use chrono::{DateTime, Utc};
use std::collections::HashMap;
use super::{GameMode, PlayerInfo, ChatMessageData, GameSession};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Room {
    pub id: String, // 방 코드 (예: "ABCD1234")
    pub name: String,
    pub description: Option<String>,
    pub owner_id: Uuid,
    pub game_mode: GameMode,
    pub max_players: u8,
    pub current_players: Vec<Uuid>,
    pub spectators: Vec<Uuid>,
    pub player_info: HashMap<Uuid, RoomPlayerInfo>,
    pub is_private: bool,
    pub password_hash: Option<String>,
    pub created_at: DateTime<Utc>,
    pub last_activity: DateTime<Utc>,
    pub status: RoomStatus,
    pub current_game_id: Option<Uuid>,
    pub settings: RoomSettings,
    pub chat_messages: Vec<ChatMessageData>,
    pub banned_users: Vec<Uuid>,
    pub moderators: Vec<Uuid>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoomPlayerInfo {
    pub user_id: Uuid,
    pub username: String,
    pub avatar_path: Option<String>,
    pub rating: u32,
    pub is_ready: bool,
    pub is_spectator: bool,
    pub joined_at: DateTime<Utc>,
    pub role: RoomRole,
    pub team: Option<u8>, // 2v2 모드용
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum RoomRole {
    Owner,
    Moderator,
    Player,
    Spectator,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum RoomStatus {
    Waiting,    // 플레이어 대기 중
    Starting,   // 게임 시작 준비 중 (카운트다운)
    InGame,     // 게임 진행 중
    Finished,   // 게임 종료
    Closed,     // 방 닫힘
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoomSettings {
    pub auto_start: bool,           // 인원이 차면 자동 시작
    pub auto_start_delay: u32,      // 자동 시작 딜레이 (초)
    pub allow_spectators: bool,     // 관전 허용
    pub max_spectators: u32,        // 최대 관전자 수
    pub chat_enabled: bool,         // 채팅 허용
    pub voice_chat_enabled: bool,   // 음성 채팅 허용
    pub allow_rejoining: bool,      // 재접속 허용
    pub kick_idle_players: bool,    // 비활성 플레이어 추방
    pub idle_timeout: u32,          // 비활성 타임아웃 (초)
    pub room_timeout: u32,          // 방 자동 삭제 타임아웃 (초)
    pub ranked_mode: bool,          // 랭크 모드
    pub team_balance: bool,         // 2v2에서 팀 밸런스 자동 조정
}

impl Default for RoomSettings {
    fn default() -> Self {
        Self {
            auto_start: false,
            auto_start_delay: 10,
            allow_spectators: true,
            max_spectators: 10,
            chat_enabled: true,
            voice_chat_enabled: false,
            allow_rejoining: true,
            kick_idle_players: true,
            idle_timeout: 300, // 5분
            room_timeout: 1800, // 30분
            ranked_mode: false,
            team_balance: true,
        }
    }
}

impl Room {
    pub fn new(
        name: String,
        owner_id: Uuid,
        owner_info: PlayerInfo,
        game_mode: GameMode,
        max_players: u8,
        is_private: bool,
        password: Option<String>,
    ) -> Self {
        let room_id = Self::generate_room_code();
        let now = Utc::now();

        let mut current_players = Vec::new();
        let mut player_info = HashMap::new();

        current_players.push(owner_id);
        player_info.insert(owner_id, RoomPlayerInfo {
            user_id: owner_id,
            username: owner_info.username,
            avatar_path: owner_info.avatar_path,
            rating: owner_info.rating.unwrap_or(1000),
            is_ready: false,
            is_spectator: false,
            joined_at: now,
            role: RoomRole::Owner,
            team: None,
        });

        let password_hash = password.map(|p| {
            bcrypt::hash(p, bcrypt::DEFAULT_COST).unwrap_or_default()
        });

        Self {
            id: room_id,
            name,
            description: None,
            owner_id,
            game_mode,
            max_players,
            current_players,
            spectators: Vec::new(),
            player_info,
            is_private,
            password_hash,
            created_at: now,
            last_activity: now,
            status: RoomStatus::Waiting,
            current_game_id: None,
            settings: RoomSettings::default(),
            chat_messages: Vec::new(),
            banned_users: Vec::new(),
            moderators: Vec::new(),
        }
    }

    // 방 코드 생성 (8자리 영숫자)
    fn generate_room_code() -> String {
        use rand::{thread_rng, Rng};
        const CHARSET: &[u8] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        let mut rng = thread_rng();

        (0..8)
            .map(|_| {
                let idx = rng.gen_range(0..CHARSET.len());
                CHARSET[idx] as char
            })
            .collect()
    }

    // 플레이어 추가
    pub fn add_player(&mut self, player_id: Uuid, player_info: PlayerInfo, password: Option<String>) -> Result<(), String> {
        // 밴 체크
        if self.banned_users.contains(&player_id) {
            return Err("방에서 추방된 사용자입니다.".to_string());
        }

        // 이미 참가 중인지 체크
        if self.current_players.contains(&player_id) || self.spectators.contains(&player_id) {
            return Err("이미 방에 참가 중입니다.".to_string());
        }

        // 비밀번호 체크
        if self.is_private {
            if let Some(ref hash) = self.password_hash {
                let provided_password = password.ok_or("비밀번호가 필요합니다.")?;
                if !bcrypt::verify(provided_password, hash).unwrap_or(false) {
                    return Err("잘못된 비밀번호입니다.".to_string());
                }
            }
        }

        // 게임 중인지 체크
        if self.status == RoomStatus::InGame || self.status == RoomStatus::Starting {
            if !self.settings.allow_rejoining {
                return Err("게임이 진행 중입니다.".to_string());
            }

            // 관전자로 추가
            return self.add_spectator(player_id, player_info);
        }

        // 방이 가득 찼는지 체크
        if self.current_players.len() >= self.max_players as usize {
            if self.settings.allow_spectators {
                return self.add_spectator(player_id, player_info);
            } else {
                return Err("방이 가득 찼습니다.".to_string());
            }
        }

        // 플레이어 추가
        self.current_players.push(player_id);
        self.player_info.insert(player_id, RoomPlayerInfo {
            user_id: player_id,
            username: player_info.username,
            avatar_path: player_info.avatar_path,
            rating: player_info.rating.unwrap_or(1000),
            is_ready: false,
            is_spectator: false,
            joined_at: Utc::now(),
            role: RoomRole::Player,
            team: self.assign_team(),
        });

        self.update_activity();

        // 자동 시작 체크
        if self.settings.auto_start && self.current_players.len() == self.max_players as usize {
            // 카운트다운 시작 (별도 로직에서 처리)
        }

        Ok(())
    }

    // 관전자 추가
    pub fn add_spectator(&mut self, spectator_id: Uuid, player_info: PlayerInfo) -> Result<(), String> {
        if !self.settings.allow_spectators {
            return Err("관전이 허용되지 않습니다.".to_string());
        }

        if self.spectators.len() >= self.settings.max_spectators as usize {
            return Err("관전자 자리가 가득 찼습니다.".to_string());
        }

        if self.spectators.contains(&spectator_id) {
            return Err("이미 관전 중입니다.".to_string());
        }

        self.spectators.push(spectator_id);
        self.player_info.insert(spectator_id, RoomPlayerInfo {
            user_id: spectator_id,
            username: player_info.username,
            avatar_path: player_info.avatar_path,
            rating: player_info.rating.unwrap_or(1000),
            is_ready: false,
            is_spectator: true,
            joined_at: Utc::now(),
            role: RoomRole::Spectator,
            team: None,
        });

        self.update_activity();
        Ok(())
    }

    // 팀 배정 (2v2 모드용)
    fn assign_team(&self) -> Option<u8> {
        if self.game_mode != GameMode::TwoVsTwo {
            return None;
        }

        // 현재 각 팀의 인원 수 계산
        let mut team_counts = [0, 0];
        for info in self.player_info.values() {
            if let Some(team) = info.team {
                if team < 2 {
                    team_counts[team as usize] += 1;
                }
            }
        }

        // 인원이 적은 팀에 배정
        if team_counts[0] <= team_counts[1] {
            Some(0)
        } else {
            Some(1)
        }
    }

    // 플레이어 제거
    pub fn remove_player(&mut self, player_id: Uuid) -> Result<(), String> {
        let was_player = self.current_players.contains(&player_id);
        let was_spectator = self.spectators.contains(&player_id);

        if !was_player && !was_spectator {
            return Err("방에 참가하지 않은 사용자입니다.".to_string());
        }

        // 플레이어/관전자 목록에서 제거
        self.current_players.retain(|&id| id != player_id);
        self.spectators.retain(|&id| id != player_id);
        self.player_info.remove(&player_id);

        // 방장이 나가면 방장 위임
        if player_id == self.owner_id && !self.current_players.is_empty() {
            self.transfer_ownership(self.current_players[0])?;
        }

        self.update_activity();

        // 방이 비었으면 삭제 예약
        if self.current_players.is_empty() && self.spectators.is_empty() {
            self.status = RoomStatus::Closed;
        }

        Ok(())
    }

    // 방장 위임
    pub fn transfer_ownership(&mut self, new_owner_id: Uuid) -> Result<(), String> {
        if !self.current_players.contains(&new_owner_id) {
            return Err("방에 참가하지 않은 사용자입니다.".to_string());
        }

        // 기존 방장을 일반 플레이어로 변경
        if let Some(old_owner_info) = self.player_info.get_mut(&self.owner_id) {
            old_owner_info.role = RoomRole::Player;
        }

        // 새 방장 설정
        self.owner_id = new_owner_id;
        if let Some(new_owner_info) = self.player_info.get_mut(&new_owner_id) {
            new_owner_info.role = RoomRole::Owner;
        }

        Ok(())
    }

    // 플레이어 추방
    pub fn kick_player(&mut self, kicker_id: Uuid, target_id: Uuid, ban: bool) -> Result<(), String> {
        // 권한 체크
        if let Some(kicker_info) = self.player_info.get(&kicker_id) {
            match kicker_info.role {
                RoomRole::Owner => {},
                RoomRole::Moderator => {
                    // 모더레이터는 방장을 추방할 수 없음
                    if let Some(target_info) = self.player_info.get(&target_id) {
                        if target_info.role == RoomRole::Owner {
                            return Err("방장을 추방할 수 없습니다.".to_string());
                        }
                    }
                },
                _ => return Err("추방 권한이 없습니다.".to_string()),
            }
        } else {
            return Err("방에 참가하지 않은 사용자입니다.".to_string());
        }

        // 자기 자신을 추방할 수 없음
        if kicker_id == target_id {
            return Err("자기 자신을 추방할 수 없습니다.".to_string());
        }

        // 플레이어 제거
        self.remove_player(target_id)?;

        // 밴 처리
        if ban {
            self.banned_users.push(target_id);
        }

        Ok(())
    }

    // 준비 상태 설정
    pub fn set_ready(&mut self, player_id: Uuid, ready: bool) -> Result<(), String> {
        if !self.current_players.contains(&player_id) {
            return Err("방에 참가하지 않은 플레이어입니다.".to_string());
        }

        if let Some(info) = self.player_info.get_mut(&player_id) {
            info.is_ready = ready;
            self.update_activity();
        }

        Ok(())
    }

    // 모든 플레이어가 준비됐는지 확인
    pub fn all_players_ready(&self) -> bool {
        if self.current_players.is_empty() {
            return false;
        }

        self.current_players.iter().all(|&player_id| {
            self.player_info.get(&player_id)
                .map(|info| info.is_ready || info.role == RoomRole::Owner) // 방장은 자동 준비
                .unwrap_or(false)
        })
    }

    // 게임 시작 가능 여부
    pub fn can_start_game(&self) -> bool {
        let min_players = match self.game_mode {
            GameMode::SinglePlayer => 1,
            GameMode::OneVsOne => 2,
            GameMode::TwoVsTwo => 4,
        };

        self.current_players.len() >= min_players &&
            self.all_players_ready() &&
            self.status == RoomStatus::Waiting
    }

    // 채팅 메시지 추가
    pub fn add_chat_message(&mut self, message: ChatMessageData) {
        // 메시지 기록 제한 (최근 100개만 유지)
        if self.chat_messages.len() >= 100 {
            self.chat_messages.remove(0);
        }

        self.chat_messages.push(message);
        self.update_activity();
    }

    // 팀 재배정 (2v2 모드)
    pub fn rebalance_teams(&mut self) -> Result<(), String> {
        if self.game_mode != GameMode::TwoVsTwo {
            return Err("2v2 모드가 아닙니다.".to_string());
        }

        if !self.settings.team_balance {
            return Err("팀 밸런스가 비활성화되어 있습니다.".to_string());
        }

        // 레이팅 기준으로 팀 재배정
        let mut players: Vec<_> = self.current_players.iter()
            .filter_map(|&id| self.player_info.get(&id).map(|info| (id, info.rating)))
            .collect();

        players.sort_by(|a, b| b.1.cmp(&a.1)); // 레이팅 높은 순으로 정렬

        // 지그재그 방식으로 팀 배정 (1,4번 vs 2,3번)
        for (index, (player_id, _)) in players.iter().enumerate() {
            let team = if index % 4 == 0 || index % 4 == 3 { 0 } else { 1 };
            if let Some(info) = self.player_info.get_mut(player_id) {
                info.team = Some(team);
            }
        }

        Ok(())
    }

    // 활동 시간 업데이트
    fn update_activity(&mut self) {
        self.last_activity = Utc::now();
    }

    // 방이 만료되었는지 확인
    pub fn is_expired(&self) -> bool {
        let timeout = chrono::Duration::seconds(self.settings.room_timeout as i64);
        Utc::now() - self.last_activity > timeout
    }

    // 방 정보 요약
    pub fn get_summary(&self) -> RoomSummary {
        RoomSummary {
            id: self.id.clone(),
            name: self.name.clone(),
            game_mode: self.game_mode.clone(),
            current_players: self.current_players.len() as u8,
            max_players: self.max_players,
            spectators: self.spectators.len() as u32,
            is_private: self.is_private,
            status: self.status.clone(),
            average_rating: self.calculate_average_rating(),
            has_password: self.password_hash.is_some(),
            created_at: self.created_at,
        }
    }

    // 평균 레이팅 계산
    fn calculate_average_rating(&self) -> u32 {
        if self.current_players.is_empty() {
            return 0;
        }

        let total_rating: u32 = self.current_players.iter()
            .filter_map(|&id| self.player_info.get(&id).map(|info| info.rating))
            .sum();

        total_rating / self.current_players.len() as u32
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoomSummary {
    pub id: String,
    pub name: String,
    pub game_mode: GameMode,
    pub current_players: u8,
    pub max_players: u8,
    pub spectators: u32,
    pub is_private: bool,
    pub status: RoomStatus,
    pub average_rating: u32,
    pub has_password: bool,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoomData {
    pub room: Room,
    pub can_join: bool,
    pub can_spectate: bool,
    pub join_error: Option<String>,
}