// src/models/user.rs
use serde::{Deserialize, Serialize};
use uuid::Uuid;
use chrono::{DateTime, Utc};
use super::{GameMode, PlayerStatus};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct User {
    pub id: Uuid,
    pub username: String,
    pub email: String,
    #[serde(skip_serializing)]
    pub password_hash: String,
    pub avatar_path: Option<String>,
    pub created_at: DateTime<Utc>,
    pub last_login: DateTime<Utc>,
    pub is_banned: bool,
    pub ban_reason: Option<String>,
    pub ban_expires_at: Option<DateTime<Utc>>,
    pub rating: u32,
    pub total_play_time: u64, // 초 단위
    pub preferences: UserPreferences,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserPreferences {
    pub theme: String, // "light", "dark", "auto"
    pub language: String, // "ko", "en", "ja", etc.
    pub sound_enabled: bool,
    pub music_enabled: bool,
    pub vibration_enabled: bool,
    pub show_ghost_piece: bool,
    pub show_next_pieces: u8, // 1-5
    pub auto_repeat_delay: u32, // 밀리초
    pub auto_repeat_rate: u32, // 밀리초
    pub soft_drop_multiplier: f32,
}

impl Default for UserPreferences {
    fn default() -> Self {
        Self {
            theme: "dark".to_string(),
            language: "ko".to_string(),
            sound_enabled: true,
            music_enabled: true,
            vibration_enabled: true,
            show_ghost_piece: true,
            show_next_pieces: 3,
            auto_repeat_delay: 167,
            auto_repeat_rate: 33,
            soft_drop_multiplier: 20.0,
        }
    }
}

impl User {
    pub fn new(username: String, email: String, password_hash: String) -> Self {
        let now = Utc::now();
        Self {
            id: Uuid::new_v4(),
            username,
            email,
            password_hash,
            avatar_path: None,
            created_at: now,
            last_login: now,
            is_banned: false,
            ban_reason: None,
            ban_expires_at: None,
            rating: 1000, // 기본 레이팅
            total_play_time: 0,
            preferences: UserPreferences::default(),
        }
    }

    pub fn is_currently_banned(&self) -> bool {
        if !self.is_banned {
            return false;
        }

        if let Some(expires_at) = self.ban_expires_at {
            Utc::now() < expires_at
        } else {
            true // 영구 밴
        }
    }

    pub fn can_play(&self) -> bool {
        !self.is_currently_banned()
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GameStats {
    pub id: i64,
    pub user_id: Uuid,
    pub game_mode: GameMode,
    pub score: u32,
    pub lines_cleared: u32,
    pub level_reached: u32,
    pub duration: u32, // 초 단위
    pub played_at: DateTime<Utc>,
    pub placement: Option<u32>, // 멀티플레이어에서의 순위
    pub is_victory: bool,
    pub pps: f32, // Pieces Per Second
    pub apm: f32, // Actions Per Minute
    pub efficiency: f32, // 효율성 점수
}

impl GameStats {
    pub fn new(
        user_id: Uuid,
        game_mode: GameMode,
        score: u32,
        lines_cleared: u32,
        level_reached: u32,
        duration: u32,
    ) -> Self {
        Self {
            id: 0, // 데이터베이스에서 자동 생성
            user_id,
            game_mode,
            score,
            lines_cleared,
            level_reached,
            duration,
            played_at: Utc::now(),
            placement: None,
            is_victory: false,
            pps: 0.0,
            apm: 0.0,
            efficiency: 0.0,
        }
    }

    pub fn calculate_derived_stats(&mut self, total_pieces: u32, total_actions: u32) {
        if self.duration > 0 {
            self.pps = total_pieces as f32 / (self.duration as f32 / 60.0);
            self.apm = total_actions as f32 / (self.duration as f32 / 60.0);

            // 효율성 = (점수 / 시간) * (라인 클리어 / 피스 수)
            let time_efficiency = self.score as f32 / self.duration as f32;
            let line_efficiency = if total_pieces > 0 {
                self.lines_cleared as f32 / total_pieces as f32
            } else {
                0.0
            };
            self.efficiency = time_efficiency * line_efficiency;
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserProfile {
    pub user: User,
    pub stats: UserStats,
    pub recent_games: Vec<GameStats>,
    pub achievements: Vec<Achievement>,
    pub friends: Vec<Friend>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserStats {
    pub total_games: u32,
    pub wins: u32,
    pub losses: u32,
    pub highest_score: u32,
    pub total_lines_cleared: u32,
    pub average_score: f32,
    pub total_play_time: u32, // 초 단위
    pub favorite_mode: Option<GameMode>,
    pub best_pps: f32,
    pub best_apm: f32,
    pub average_placement: f32, // 멀티플레이어 평균 순위
    pub win_rate: f32,
    pub current_streak: u32,
    pub best_streak: u32,
}

impl Default for UserStats {
    fn default() -> Self {
        Self {
            total_games: 0,
            wins: 0,
            losses: 0,
            highest_score: 0,
            total_lines_cleared: 0,
            average_score: 0.0,
            total_play_time: 0,
            favorite_mode: None,
            best_pps: 0.0,
            best_apm: 0.0,
            average_placement: 0.0,
            win_rate: 0.0,
            current_streak: 0,
            best_streak: 0,
        }
    }
}

impl UserStats {
    pub fn update_from_game(&mut self, game_stats: &GameStats) {
        self.total_games += 1;
        self.total_lines_cleared += game_stats.lines_cleared;
        self.total_play_time += game_stats.duration;

        if game_stats.score > self.highest_score {
            self.highest_score = game_stats.score;
        }

        if game_stats.pps > self.best_pps {
            self.best_pps = game_stats.pps;
        }

        if game_stats.apm > self.best_apm {
            self.best_apm = game_stats.apm;
        }

        // 평균 점수 업데이트
        self.average_score = (self.average_score * (self.total_games - 1) as f32 + game_stats.score as f32) / self.total_games as f32;

        // 승패 업데이트
        if game_stats.is_victory {
            self.wins += 1;
            self.current_streak += 1;
            if self.current_streak > self.best_streak {
                self.best_streak = self.current_streak;
            }
        } else {
            self.losses += 1;
            self.current_streak = 0;
        }

        // 승률 계산
        self.win_rate = self.wins as f32 / self.total_games as f32;

        // 평균 순위 업데이트 (멀티플레이어)
        if let Some(placement) = game_stats.placement {
            self.average_placement = (self.average_placement * (self.total_games - 1) as f32 + placement as f32) / self.total_games as f32;
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Achievement {
    pub id: String,
    pub name: String,
    pub description: String,
    pub icon: String,
    pub unlocked_at: Option<DateTime<Utc>>,
    pub progress: u32,
    pub target: u32,
    pub category: AchievementCategory,
    pub rarity: AchievementRarity,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum AchievementCategory {
    Score,
    Lines,
    Games,
    Time,
    Skill,
    Social,
    Special,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum AchievementRarity {
    Common,
    Uncommon,
    Rare,
    Epic,
    Legendary,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Friend {
    pub id: Uuid,
    pub user: User,
    pub status: FriendStatus,
    pub added_at: DateTime<Utc>,
    pub last_played_together: Option<DateTime<Utc>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FriendStatus {
    Online,
    InGame,
    Away,
    Offline,
}

// 온라인 사용자 정보
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OnlineUser {
    pub user_id: Uuid,
    pub username: String,
    pub avatar_path: Option<String>,
    pub status: PlayerStatus,
    pub current_room_id: Option<String>,
    pub current_game_id: Option<String>,
    pub socket_id: String,
    pub last_activity: DateTime<Utc>,
    pub rating: u32,
}

impl OnlineUser {
    pub fn new(user: &User, socket_id: String) -> Self {
        Self {
            user_id: user.id,
            username: user.username.clone(),
            avatar_path: user.avatar_path.clone(),
            status: PlayerStatus::Online,
            current_room_id: None,
            current_game_id: None,
            socket_id,
            last_activity: Utc::now(),
            rating: user.rating,
        }
    }

    pub fn update_activity(&mut self) {
        self.last_activity = Utc::now();
    }

    pub fn is_active(&self) -> bool {
        let timeout = chrono::Duration::minutes(5);
        Utc::now() - self.last_activity < timeout
    }
}

// 레이팅 시스템
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RatingChange {
    pub user_id: Uuid,
    pub old_rating: u32,
    pub new_rating: u32,
    pub change: i32,
    pub game_id: String,
    pub timestamp: DateTime<Utc>,
}

impl RatingChange {
    pub fn new(user_id: Uuid, old_rating: u32, new_rating: u32, game_id: String) -> Self {
        Self {
            user_id,
            old_rating,
            new_rating,
            change: new_rating as i32 - old_rating as i32,
            game_id,
            timestamp: Utc::now(),
        }
    }
}

// ELO 레이팅 계산
pub fn calculate_rating_change(
    player_rating: u32,
    opponent_rating: u32,
    player_won: bool,
    k_factor: f32,
) -> i32 {
    let expected_score = 1.0 / (1.0 + 10_f32.powf((opponent_rating as f32 - player_rating as f32) / 400.0));
    let actual_score = if player_won { 1.0 } else { 0.0 };
    let rating_change = k_factor * (actual_score - expected_score);

    rating_change.round() as i32
}

// K-팩터 계산 (게임 수에 따라 조정)
pub fn get_k_factor(total_games: u32, rating: u32) -> f32 {
    if total_games < 30 {
        40.0 // 신규 플레이어
    } else if rating < 1200 {
        32.0 // 낮은 레이팅
    } else if rating < 2000 {
        24.0 // 중간 레이팅
    } else {
        16.0 // 높은 레이팅
    }
}