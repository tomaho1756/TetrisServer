// src/database/mod.rs
use sqlx::{sqlite::SqlitePool, Row, migrate::MigrateDatabase, Sqlite};
use uuid::Uuid;
use chrono::{DateTime, Utc};
use crate::models::*;
use std::env;

#[derive(Clone)]
pub struct Database {
    pool: SqlitePool,
}

impl Database {
    pub async fn new() -> Result<Self> {
        let database_url = env::var("DATABASE_URL")
            .unwrap_or_else(|_| "sqlite:tetris.db".to_string());

        // 데이터베이스가 존재하지 않으면 생성
        if !Sqlite::database_exists(&database_url).await.unwrap_or(false) {
            println!("🗄️ 데이터베이스 생성 중: {}", database_url);
            Sqlite::create_database(&database_url).await
                .map_err(|e| TetrisError::Database(e))?;
        }

        let pool = SqlitePool::connect(&database_url).await
            .map_err(|e| TetrisError::Database(e))?;

        println!("✅ 데이터베이스 연결 완료: {}", database_url);

        Ok(Database { pool })
    }

    pub async fn migrate(&self) -> Result<()> {
        println!("🔄 데이터베이스 마이그레이션 실행 중...");

        // 사용자 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS users (
                id TEXT PRIMARY KEY,
                username TEXT UNIQUE NOT NULL,
                email TEXT UNIQUE NOT NULL,
                password_hash TEXT NOT NULL,
                avatar_path TEXT,
                created_at TEXT NOT NULL,
                last_login TEXT NOT NULL,
                is_banned BOOLEAN DEFAULT FALSE,
                ban_reason TEXT,
                ban_expires_at TEXT,
                rating INTEGER DEFAULT 1000,
                total_play_time INTEGER DEFAULT 0,
                preferences_theme TEXT DEFAULT 'dark',
                preferences_language TEXT DEFAULT 'ko',
                preferences_sound_enabled BOOLEAN DEFAULT TRUE,
                preferences_music_enabled BOOLEAN DEFAULT TRUE,
                preferences_vibration_enabled BOOLEAN DEFAULT TRUE,
                preferences_show_ghost_piece BOOLEAN DEFAULT TRUE,
                preferences_show_next_pieces INTEGER DEFAULT 3,
                preferences_auto_repeat_delay INTEGER DEFAULT 167,
                preferences_auto_repeat_rate INTEGER DEFAULT 33,
                preferences_soft_drop_multiplier REAL DEFAULT 20.0,
                is_admin BOOLEAN DEFAULT FALSE
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 게임 통계 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS game_stats (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id TEXT NOT NULL,
                game_mode TEXT NOT NULL,
                score INTEGER NOT NULL,
                lines_cleared INTEGER NOT NULL,
                level_reached INTEGER NOT NULL,
                duration INTEGER NOT NULL,
                played_at TEXT NOT NULL,
                placement INTEGER,
                is_victory BOOLEAN DEFAULT FALSE,
                pps REAL DEFAULT 0.0,
                apm REAL DEFAULT 0.0,
                efficiency REAL DEFAULT 0.0,
                FOREIGN KEY (user_id) REFERENCES users (id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 친구 관계 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS friendships (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id TEXT NOT NULL,
                friend_id TEXT NOT NULL,
                status TEXT NOT NULL,
                created_at TEXT NOT NULL,
                FOREIGN KEY (user_id) REFERENCES users (id),
                FOREIGN KEY (friend_id) REFERENCES users (id),
                UNIQUE(user_id, friend_id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 친구 요청 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS friend_requests (
                id TEXT PRIMARY KEY,
                from_user_id TEXT NOT NULL,
                to_user_id TEXT NOT NULL,
                message TEXT,
                status TEXT NOT NULL,
                created_at TEXT NOT NULL,
                FOREIGN KEY (from_user_id) REFERENCES users (id),
                FOREIGN KEY (to_user_id) REFERENCES users (id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 게임 세션 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS game_sessions (
                id TEXT PRIMARY KEY,
                game_mode TEXT NOT NULL,
                status TEXT NOT NULL,
                created_at TEXT NOT NULL,
                started_at TEXT,
                finished_at TEXT,
                winner_id TEXT,
                room_id TEXT,
                FOREIGN KEY (winner_id) REFERENCES users (id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 게임 참가자 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS game_participants (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                game_id TEXT NOT NULL,
                user_id TEXT NOT NULL,
                final_score INTEGER DEFAULT 0,
                final_level INTEGER DEFAULT 1,
                lines_cleared INTEGER DEFAULT 0,
                placement INTEGER,
                left_at TEXT,
                FOREIGN KEY (game_id) REFERENCES game_sessions (id),
                FOREIGN KEY (user_id) REFERENCES users (id),
                UNIQUE(game_id, user_id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 레이팅 변화 기록 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS rating_changes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id TEXT NOT NULL,
                old_rating INTEGER NOT NULL,
                new_rating INTEGER NOT NULL,
                change_amount INTEGER NOT NULL,
                game_id TEXT NOT NULL,
                timestamp TEXT NOT NULL,
                FOREIGN KEY (user_id) REFERENCES users (id),
                FOREIGN KEY (game_id) REFERENCES game_sessions (id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 방 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS rooms (
                id TEXT PRIMARY KEY,
                name TEXT NOT NULL,
                code TEXT UNIQUE NOT NULL,
                game_mode TEXT NOT NULL,
                max_players INTEGER NOT NULL,
                is_private BOOLEAN DEFAULT FALSE,
                password_hash TEXT,
                description TEXT,
                created_by TEXT NOT NULL,
                created_at TEXT NOT NULL,
                is_active BOOLEAN DEFAULT TRUE,
                current_game_id TEXT,
                FOREIGN KEY (created_by) REFERENCES users (id),
                FOREIGN KEY (current_game_id) REFERENCES game_sessions (id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 채팅 메시지 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS chat_messages (
                id TEXT PRIMARY KEY,
                room_id TEXT,
                game_id TEXT,
                sender_id TEXT NOT NULL,
                message TEXT NOT NULL,
                message_type TEXT NOT NULL,
                timestamp TEXT NOT NULL,
                FOREIGN KEY (room_id) REFERENCES rooms (id),
                FOREIGN KEY (game_id) REFERENCES game_sessions (id),
                FOREIGN KEY (sender_id) REFERENCES users (id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 도전과제 테이블 생성
        sqlx::query(r#"
            CREATE TABLE IF NOT EXISTS user_achievements (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id TEXT NOT NULL,
                achievement_id TEXT NOT NULL,
                progress INTEGER DEFAULT 0,
                target INTEGER NOT NULL,
                unlocked_at TEXT,
                FOREIGN KEY (user_id) REFERENCES users (id),
                UNIQUE(user_id, achievement_id)
            )
        "#).execute(&self.pool).await
            .map_err(|e| TetrisError::Database(e))?;

        // 인덱스 생성
        self.create_indexes().await?;

        println!("✅ 데이터베이스 마이그레이션 완료");
        Ok(())
    }

    async fn create_indexes(&self) -> Result<()> {
        let indexes = vec![
            "CREATE INDEX IF NOT EXISTS idx_users_email ON users(email)",
            "CREATE INDEX IF NOT EXISTS idx_users_username ON users(username)",
            "CREATE INDEX IF NOT EXISTS idx_users_rating ON users(rating DESC)",
            "CREATE INDEX IF NOT EXISTS idx_game_stats_user_id ON game_stats(user_id)",
            "CREATE INDEX IF NOT EXISTS idx_game_stats_played_at ON game_stats(played_at DESC)",
            "CREATE INDEX IF NOT EXISTS idx_game_stats_score ON game_stats(score DESC)",
            "CREATE INDEX IF NOT EXISTS idx_friendships_user_id ON friendships(user_id)",
            "CREATE INDEX IF NOT EXISTS idx_friend_requests_to_user ON friend_requests(to_user_id)",
            "CREATE INDEX IF NOT EXISTS idx_game_sessions_status ON game_sessions(status)",
            "CREATE INDEX IF NOT EXISTS idx_game_participants_game_id ON game_participants(game_id)",
            "CREATE INDEX IF NOT EXISTS idx_rating_changes_user_id ON rating_changes(user_id)",
            "CREATE INDEX IF NOT EXISTS idx_rooms_code ON rooms(code)",
            "CREATE INDEX IF NOT EXISTS idx_rooms_active ON rooms(is_active)",
            "CREATE INDEX IF NOT EXISTS idx_chat_messages_room_id ON chat_messages(room_id)",
            "CREATE INDEX IF NOT EXISTS idx_chat_messages_timestamp ON chat_messages(timestamp DESC)",
        ];

        for index_sql in indexes {
            sqlx::query(index_sql).execute(&self.pool).await
                .map_err(|e| TetrisError::Database(e))?;
        }

        Ok(())
    }

    // 사용자 관련 메서드
    pub async fn create_user(&self, user: &User) -> Result<()> {
        sqlx::query(r#"
            INSERT INTO users (
                id, username, email, password_hash, avatar_path, created_at, last_login,
                is_banned, ban_reason, ban_expires_at, rating, total_play_time,
                preferences_theme, preferences_language, preferences_sound_enabled,
                preferences_music_enabled, preferences_vibration_enabled, preferences_show_ghost_piece,
                preferences_show_next_pieces, preferences_auto_repeat_delay, preferences_auto_repeat_rate,
                preferences_soft_drop_multiplier, is_admin
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        "#)
        .bind(user.id.to_string())
        .bind(&user.username)
        .bind(&user.email)
        .bind(&user.password_hash)
        .bind(&user.avatar_path)
        .bind(user.created_at.to_rfc3339())
        .bind(user.last_login.to_rfc3339())
        .bind(user.is_banned)
        .bind(&user.ban_reason)
        .bind(user.ban_expires_at.map(|dt| dt.to_rfc3339()))
        .bind(user.rating as i64)
        .bind(user.total_play_time as i64)
        .bind(&user.preferences.theme)
        .bind(&user.preferences.language)
        .bind(user.preferences.sound_enabled)
        .bind(user.preferences.music_enabled)
        .bind(user.preferences.vibration_enabled)
        .bind(user.preferences.show_ghost_piece)
        .bind(user.preferences.show_next_pieces as i64)
        .bind(user.preferences.auto_repeat_delay as i64)
        .bind(user.preferences.auto_repeat_rate as i64)
        .bind(user.preferences.soft_drop_multiplier)
        .bind(false) // is_admin
        .execute(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn get_user_by_email(&self, email: &str) -> Result<User> {
        let row = sqlx::query(r#"
            SELECT id, username, email, password_hash, avatar_path, created_at, last_login,
                   is_banned, ban_reason, ban_expires_at, rating, total_play_time,
                   preferences_theme, preferences_language, preferences_sound_enabled,
                   preferences_music_enabled, preferences_vibration_enabled, preferences_show_ghost_piece,
                   preferences_show_next_pieces, preferences_auto_repeat_delay, 
                   preferences_auto_repeat_rate, preferences_soft_drop_multiplier, is_admin
            FROM users WHERE email = ?
        "#)
        .bind(email)
        .fetch_one(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        self.row_to_user(row)
    }

    pub async fn get_user_by_id(&self, user_id: Uuid) -> Result<Option<User>> {
        let row = sqlx::query(r#"
            SELECT id, username, email, password_hash, avatar_path, created_at, last_login,
                   is_banned, ban_reason, ban_expires_at, rating, total_play_time,
                   preferences_theme, preferences_language, preferences_sound_enabled,
                   preferences_music_enabled, preferences_vibration_enabled, preferences_show_ghost_piece,
                   preferences_show_next_pieces, preferences_auto_repeat_delay, 
                   preferences_auto_repeat_rate, preferences_soft_drop_multiplier, is_admin
            FROM users WHERE id = ?
        "#)
        .bind(user_id.to_string())
        .fetch_optional(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        if let Some(row) = row {
            Ok(Some(self.row_to_user(row)?))
        } else {
            Ok(None)
        }
    }

    // 사용자 조회 (User 반환, 존재하지 않으면 에러)
    pub async fn get_user_by_id_required(&self, user_id: Uuid) -> Result<User> {
        self.get_user_by_id(user_id).await?
            .ok_or(TetrisError::UserNotFound)
    }

    pub async fn get_user_by_username(&self, username: &str) -> Result<User> {
        let row = sqlx::query(r#"
            SELECT id, username, email, password_hash, avatar_path, created_at, last_login,
                   is_banned, ban_reason, ban_expires_at, rating, total_play_time,
                   preferences_theme, preferences_language, preferences_sound_enabled,
                   preferences_music_enabled, preferences_vibration_enabled, preferences_show_ghost_piece,
                   preferences_show_next_pieces, preferences_auto_repeat_delay, 
                   preferences_auto_repeat_rate, preferences_soft_drop_multiplier, is_admin
            FROM users WHERE username = ?
        "#)
        .bind(username)
        .fetch_one(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        self.row_to_user(row)
    }

    pub async fn update_last_login(&self, user_id: Uuid) -> Result<()> {
        sqlx::query("UPDATE users SET last_login = ? WHERE id = ?")
            .bind(Utc::now().to_rfc3339())
            .bind(user_id.to_string())
            .execute(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn update_user_password(&self, user_id: Uuid, password_hash: String) -> Result<()> {
        sqlx::query("UPDATE users SET password_hash = ? WHERE id = ?")
            .bind(password_hash)
            .bind(user_id.to_string())
            .execute(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn update_user_profile(&self, user_id: Uuid, username: Option<String>, avatar_path: Option<String>) -> Result<User> {
        if let Some(username) = username {
            sqlx::query("UPDATE users SET username = ? WHERE id = ?")
                .bind(&username)
                .bind(user_id.to_string())
                .execute(&self.pool)
                .await
                .map_err(|e| TetrisError::Database(e))?;
        }

        if let Some(avatar_path) = avatar_path {
            sqlx::query("UPDATE users SET avatar_path = ? WHERE id = ?")
                .bind(&avatar_path)
                .bind(user_id.to_string())
                .execute(&self.pool)
                .await
                .map_err(|e| TetrisError::Database(e))?;
        }

        self.get_user_by_id(user_id).await
    }

    pub async fn update_user_preferences(&self, user_id: Uuid, preferences: &UserPreferences) -> Result<()> {
        sqlx::query(r#"
            UPDATE users SET 
                preferences_theme = ?,
                preferences_language = ?,
                preferences_sound_enabled = ?,
                preferences_music_enabled = ?,
                preferences_vibration_enabled = ?,
                preferences_show_ghost_piece = ?,
                preferences_show_next_pieces = ?,
                preferences_auto_repeat_delay = ?,
                preferences_auto_repeat_rate = ?,
                preferences_soft_drop_multiplier = ?
            WHERE id = ?
        "#)
        .bind(&preferences.theme)
        .bind(&preferences.language)
        .bind(preferences.sound_enabled)
        .bind(preferences.music_enabled)
        .bind(preferences.vibration_enabled)
        .bind(preferences.show_ghost_piece)
        .bind(preferences.show_next_pieces as i64)
        .bind(preferences.auto_repeat_delay as i64)
        .bind(preferences.auto_repeat_rate as i64)
        .bind(preferences.soft_drop_multiplier)
        .bind(user_id.to_string())
        .execute(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn delete_user(&self, user_id: Uuid) -> Result<()> {
        sqlx::query("DELETE FROM users WHERE id = ?")
            .bind(user_id.to_string())
            .execute(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn ban_user(&self, user_id: Uuid, reason: String, expires_at: Option<DateTime<Utc>>) -> Result<()> {
        sqlx::query("UPDATE users SET is_banned = TRUE, ban_reason = ?, ban_expires_at = ? WHERE id = ?")
            .bind(reason)
            .bind(expires_at.map(|dt| dt.to_rfc3339()))
            .bind(user_id.to_string())
            .execute(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn unban_user(&self, user_id: Uuid) -> Result<()> {
        sqlx::query("UPDATE users SET is_banned = FALSE, ban_reason = NULL, ban_expires_at = NULL WHERE id = ?")
            .bind(user_id.to_string())
            .execute(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn is_admin(&self, user_id: Uuid) -> Result<bool> {
        let row = sqlx::query("SELECT is_admin FROM users WHERE id = ?")
            .bind(user_id.to_string())
            .fetch_one(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(row.get::<bool, _>("is_admin"))
    }

    pub async fn search_users(&self, query: &str, limit: i32) -> Result<Vec<User>> {
        let rows = sqlx::query(r#"
            SELECT id, username, email, password_hash, avatar_path, created_at, last_login,
                   is_banned, ban_reason, ban_expires_at, rating, total_play_time,
                   preferences_theme, preferences_language, preferences_sound_enabled,
                   preferences_music_enabled, preferences_vibration_enabled, preferences_show_ghost_piece,
                   preferences_show_next_pieces, preferences_auto_repeat_delay, 
                   preferences_auto_repeat_rate, preferences_soft_drop_multiplier, is_admin
            FROM users 
            WHERE username LIKE ? OR email LIKE ?
            ORDER BY username
            LIMIT ?
        "#)
        .bind(format!("%{}%", query))
        .bind(format!("%{}%", query))
        .bind(limit)
        .fetch_all(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        let mut users = Vec::new();
        for row in rows {
            users.push(self.row_to_user(row)?);
        }

        Ok(users)
    }

    // 게임 통계 관련 메서드
    pub async fn save_game_stats(&self, stats: &GameStats) -> Result<()> {
        sqlx::query(r#"
            INSERT INTO game_stats (
                user_id, game_mode, score, lines_cleared, level_reached, duration,
                played_at, placement, is_victory, pps, apm, efficiency
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        "#)
        .bind(stats.user_id.to_string())
        .bind(format!("{:?}", stats.game_mode))
        .bind(stats.score as i64)
        .bind(stats.lines_cleared as i64)
        .bind(stats.level_reached as i64)
        .bind(stats.duration as i64)
        .bind(stats.played_at.to_rfc3339())
        .bind(stats.placement.map(|p| p as i64))
        .bind(stats.is_victory)
        .bind(stats.pps)
        .bind(stats.apm)
        .bind(stats.efficiency)
        .execute(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn get_user_game_stats(&self, user_id: Uuid) -> Result<Vec<GameStats>> {
        let rows = sqlx::query(r#"
            SELECT id, user_id, game_mode, score, lines_cleared, level_reached, duration,
                   played_at, placement, is_victory, pps, apm, efficiency
            FROM game_stats 
            WHERE user_id = ?
            ORDER BY played_at DESC
        "#)
        .bind(user_id.to_string())
        .fetch_all(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        let mut stats = Vec::new();
        for row in rows {
            let game_mode_str: String = row.get("game_mode");
            let game_mode = match game_mode_str.as_str() {
                "SinglePlayer" => GameMode::SinglePlayer,
                "OneVsOne" => GameMode::OneVsOne,
                "TwoVsTwo" => GameMode::TwoVsTwo,
                _ => GameMode::SinglePlayer,
            };

            let played_at_str: String = row.get("played_at");
            let played_at = DateTime::parse_from_rfc3339(&played_at_str)
                .map_err(|_| TetrisError::InvalidInput("Invalid date format".to_string()))?
                .with_timezone(&Utc);

            stats.push(GameStats {
                id: row.get::<i64, _>("id"),
                user_id,
                game_mode,
                score: row.get::<i64, _>("score") as u32,
                lines_cleared: row.get::<i64, _>("lines_cleared") as u32,
                level_reached: row.get::<i64, _>("level_reached") as u32,
                duration: row.get::<i64, _>("duration") as u32,
                played_at,
                placement: row.get::<Option<i64>, _>("placement").map(|p| p as u32),
                is_victory: row.get("is_victory"),
                pps: row.get::<Option<f64>, _>("pps").unwrap_or(0.0) as f32,
                apm: row.get::<Option<f64>, _>("apm").unwrap_or(0.0) as f32,
                efficiency: row.get::<Option<f64>, _>("efficiency").unwrap_or(0.0) as f32,
            });
        }

        Ok(stats)
    }

    pub async fn get_user_recent_games(&self, user_id: Uuid, limit: u32) -> Result<Vec<GameStats>> {
        let stats = self.get_user_game_stats(user_id).await?;
        Ok(stats.into_iter().take(limit as usize).collect())
    }

    pub async fn get_user_stats(&self, user_id: Uuid) -> Result<UserStats> {
        let row = sqlx::query(r#"
            SELECT 
                COUNT(*) as total_games,
                SUM(CASE WHEN is_victory = 1 THEN 1 ELSE 0 END) as wins,
                SUM(CASE WHEN is_victory = 0 THEN 1 ELSE 0 END) as losses,
                MAX(score) as highest_score,
                SUM(lines_cleared) as total_lines_cleared,
                AVG(score) as average_score,
                SUM(duration) as total_play_time,
                MAX(pps) as best_pps,
                MAX(apm) as best_apm,
                AVG(CAST(placement AS REAL)) as average_placement
            FROM game_stats WHERE user_id = ?
        "#)
        .bind(user_id.to_string())
        .fetch_one(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        let total_games: i64 = row.get("total_games");
        let wins: i64 = row.get("wins");
        let losses: i64 = row.get("losses");

        Ok(UserStats {
            total_games: total_games as u32,
            wins: wins as u32,
            losses: losses as u32,
            highest_score: row.get::<i64, _>("highest_score") as u32,
            total_lines_cleared: row.get::<i64, _>("total_lines_cleared") as u32,
            average_score: row.get::<Option<f64>, _>("average_score").unwrap_or(0.0) as f32,
            total_play_time: row.get::<i64, _>("total_play_time") as u32,
            favorite_mode: None, // TODO: 가장 많이 플레이한 모드 계산
            best_pps: row.get::<Option<f64>, _>("best_pps").unwrap_or(0.0) as f32,
            best_apm: row.get::<Option<f64>, _>("best_apm").unwrap_or(0.0) as f32,
            average_placement: row.get::<Option<f64>, _>("average_placement").unwrap_or(0.0) as f32,
            win_rate: if total_games > 0 { wins as f32 / total_games as f32 } else { 0.0 },
            current_streak: 0, // TODO: 현재 연승 계산
            best_streak: 0, // TODO: 최고 연승 계산
        })
    }

    pub async fn get_leaderboard(&self, limit: u32) -> Result<Vec<UserStatsResponse>> {
        let rows = sqlx::query(r#"
            SELECT 
                u.id, u.username, u.rating,
                COUNT(gs.id) as total_games,
                SUM(CASE WHEN gs.is_victory = 1 THEN 1 ELSE 0 END) as wins,
                SUM(CASE WHEN gs.is_victory = 0 THEN 1 ELSE 0 END) as losses,
                MAX(gs.score) as highest_score,
                SUM(gs.lines_cleared) as total_lines_cleared,
                AVG(gs.score) as average_score
            FROM users u
            LEFT JOIN game_stats gs ON u.id = gs.user_id
            GROUP BY u.id, u.username, u.rating
            ORDER BY u.rating DESC
            LIMIT ?
        "#)
        .bind(limit as i64)
        .fetch_all(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        let mut leaderboard = Vec::new();
        for row in rows {
            let user_id_str: String = row.get("id");
            let user_id = Uuid::parse_str(&user_id_str)
                .map_err(|_| TetrisError::InvalidInput("Invalid UUID".to_string()))?;

            leaderboard.push(UserStatsResponse {
                user_id: user_id.to_string(),
                username: row.get("username"),
                total_games: row.get::<i64, _>("total_games") as u32,
                wins: row.get::<i64, _>("wins") as u32,
                losses: row.get::<i64, _>("losses") as u32,
                highest_score: row.get::<i64, _>("highest_score") as u32,
                total_lines_cleared: row.get::<i64, _>("total_lines_cleared") as u32,
                average_score: row.get::<Option<f64>, _>("average_score").unwrap_or(0.0) as f32,
            });
        }

        Ok(leaderboard)
    }

    pub async fn get_top_users_by_score(&self, limit: i32) -> Result<Vec<(User, u32)>> {
        let rows = sqlx::query(r#"
            SELECT 
                u.id, u.username, u.email, u.password_hash, u.avatar_path, u.created_at, u.last_login,
                u.is_banned, u.ban_reason, u.ban_expires_at, u.rating, u.total_play_time,
                u.preferences_theme, u.preferences_language, u.preferences_sound_enabled,
                u.preferences_music_enabled, u.preferences_vibration_enabled, u.preferences_show_ghost_piece,
                u.preferences_show_next_pieces, u.preferences_auto_repeat_delay, 
                u.preferences_auto_repeat_rate, u.preferences_soft_drop_multiplier, u.is_admin,
                MAX(gs.score) as highest_score
            FROM users u
            LEFT JOIN game_stats gs ON u.id = gs.user_id
            GROUP BY u.id
            ORDER BY highest_score DESC
            LIMIT ?
        "#)
        .bind(limit)
        .fetch_all(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        let mut results = Vec::new();
        for row in rows {
            let user = self.row_to_user(row.clone())?;
            let highest_score = row.get::<i64, _>("highest_score") as u32;
            results.push((user, highest_score));
        }

        Ok(results)
    }

    // 친구 관련 메서드
    pub async fn get_user_friends(&self, user_id: Uuid) -> Result<Vec<Friend>> {
        let rows = sqlx::query(r#"
            SELECT 
                f.id, f.status, f.created_at,
                u.id as friend_id, u.username, u.email, u.password_hash, u.avatar_path, 
                u.created_at as friend_created_at, u.last_login, u.is_banned, u.ban_reason, 
                u.ban_expires_at, u.rating, u.total_play_time, u.preferences_theme, 
                u.preferences_language, u.preferences_sound_enabled, u.preferences_music_enabled, 
                u.preferences_vibration_enabled, u.preferences_show_ghost_piece, 
                u.preferences_show_next_pieces, u.preferences_auto_repeat_delay, 
                u.preferences_auto_repeat_rate, u.preferences_soft_drop_multiplier, u.is_admin
            FROM friendships f
            JOIN users u ON f.friend_id = u.id
            WHERE f.user_id = ? AND f.status = 'accepted'
        "#)
        .bind(user_id.to_string())
        .fetch_all(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        let mut friends = Vec::new();
        for row in rows {
            let friend_user = self.row_to_user(row.clone())?;
            let created_at_str: String = row.get("created_at");
            let created_at = DateTime::parse_from_rfc3339(&created_at_str)
                .map_err(|_| TetrisError::InvalidInput("Invalid date format".to_string()))?
                .with_timezone(&Utc);

            friends.push(Friend {
                id: Uuid::parse_str(&row.get::<String, _>("friend_id"))
                    .map_err(|_| TetrisError::InvalidInput("Invalid UUID".to_string()))?,
                user: friend_user,
                status: FriendStatus::Online, // TODO: 실제 온라인 상태 확인
                added_at: created_at,
                last_played_together: None, // TODO: 마지막 함께 플레이한 시간 계산
            });
        }

        Ok(friends)
    }

    pub async fn are_friends(&self, user_id: Uuid, friend_id: Uuid) -> Result<bool> {
        let count = sqlx::query("SELECT COUNT(*) as count FROM friendships WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?) AND status = 'accepted'")
            .bind(user_id.to_string())
            .bind(friend_id.to_string())
            .bind(friend_id.to_string())
            .bind(user_id.to_string())
            .fetch_one(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(count.get::<i64, _>("count") > 0)
    }

    pub async fn has_pending_friend_request(&self, from_user_id: Uuid, to_user_id: Uuid) -> Result<bool> {
        let count = sqlx::query("SELECT COUNT(*) as count FROM friend_requests WHERE from_user_id = ? AND to_user_id = ? AND status = 'pending'")
            .bind(from_user_id.to_string())
            .bind(to_user_id.to_string())
            .fetch_one(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(count.get::<i64, _>("count") > 0)
    }

    pub async fn create_friend_request(&self, from_user_id: Uuid, to_user_id: Uuid, message: Option<String>) -> Result<()> {
        let request_id = Uuid::new_v4();

        sqlx::query(r#"
            INSERT INTO friend_requests (id, from_user_id, to_user_id, message, status, created_at)
            VALUES (?, ?, ?, ?, 'pending', ?)
        "#)
        .bind(request_id.to_string())
        .bind(from_user_id.to_string())
        .bind(to_user_id.to_string())
        .bind(message)
        .bind(Utc::now().to_rfc3339())
        .execute(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn accept_friend_request(&self, request_id: String) -> Result<()> {
        // 요청 정보 가져오기
        let request = sqlx::query("SELECT from_user_id, to_user_id FROM friend_requests WHERE id = ? AND status = 'pending'")
            .bind(&request_id)
            .fetch_one(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        let from_user_id: String = request.get("from_user_id");
        let to_user_id: String = request.get("to_user_id");

        // 트랜잭션 시작
        let mut tx = self.pool.begin().await.map_err(|e| TetrisError::Database(e))?;

        // 친구 관계 생성 (양방향)
        sqlx::query("INSERT INTO friendships (user_id, friend_id, status, created_at) VALUES (?, ?, 'accepted', ?)")
            .bind(&from_user_id)
            .bind(&to_user_id)
            .bind(Utc::now().to_rfc3339())
            .execute(&mut *tx)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        sqlx::query("INSERT INTO friendships (user_id, friend_id, status, created_at) VALUES (?, ?, 'accepted', ?)")
            .bind(&to_user_id)
            .bind(&from_user_id)
            .bind(Utc::now().to_rfc3339())
            .execute(&mut *tx)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        // 요청 상태 업데이트
        sqlx::query("UPDATE friend_requests SET status = 'accepted' WHERE id = ?")
            .bind(&request_id)
            .execute(&mut *tx)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        tx.commit().await.map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn decline_friend_request(&self, request_id: String) -> Result<()> {
        sqlx::query("UPDATE friend_requests SET status = 'declined' WHERE id = ?")
            .bind(request_id)
            .execute(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    pub async fn remove_friend(&self, user_id: Uuid, friend_id: Uuid) -> Result<()> {
        sqlx::query("DELETE FROM friendships WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)")
            .bind(user_id.to_string())
            .bind(friend_id.to_string())
            .bind(friend_id.to_string())
            .bind(user_id.to_string())
            .execute(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    // 도전과제 관련 메서드
    pub async fn get_user_achievements(&self, user_id: Uuid) -> Result<Vec<Achievement>> {
        // TODO: 도전과제 시스템 구현
        Ok(vec![])
    }

    pub async fn create_user_achievement(&self, user_id: Uuid, achievement: &Achievement) -> Result<()> {
        sqlx::query(r#"
            INSERT INTO user_achievements (user_id, achievement_id, progress, target, unlocked_at)
            VALUES (?, ?, ?, ?, ?)
        "#)
        .bind(user_id.to_string())
        .bind(&achievement.id)
        .bind(achievement.progress as i64)
        .bind(achievement.target as i64)
        .bind(achievement.unlocked_at.map(|dt| dt.to_rfc3339()))
        .execute(&self.pool)
        .await
        .map_err(|e| TetrisError::Database(e))?;

        Ok(())
    }

    // 관리자 통계 관련 메서드
    pub async fn get_total_users_count(&self) -> Result<u64> {
        let row = sqlx::query("SELECT COUNT(*) as count FROM users")
            .fetch_one(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(row.get::<i64, _>("count") as u64)
    }

    pub async fn get_total_games_count(&self) -> Result<u64> {
        let row = sqlx::query("SELECT COUNT(*) as count FROM game_stats")
            .fetch_one(&self.pool)
            .await
            .map_err(|e| TetrisError::Database(e))?;

        Ok(row.get::<i64, _>("count") as u64)
    }

    // Helper 메서드
    fn row_to_user(&self, row: sqlx::sqlite::SqliteRow) -> Result<User> {
        let id_str: String = row.get("id");
        let id = Uuid::parse_str(&id_str)
            .map_err(|_| TetrisError::InvalidInput("Invalid UUID".to_string()))?;

        let created_at_str: String = row.get("created_at");
        let created_at = DateTime::parse_from_rfc3339(&created_at_str)
            .map_err(|_| TetrisError::InvalidInput("Invalid date format".to_string()))?
            .with_timezone(&Utc);

        let last_login_str: String = row.get("last_login");
        let last_login = DateTime::parse_from_rfc3339(&last_login_str)
            .map_err(|_| TetrisError::InvalidInput("Invalid date format".to_string()))?
            .with_timezone(&Utc);

        let ban_expires_at = if let Some(ban_expires_str) = row.get::<Option<String>, _>("ban_expires_at") {
            Some(DateTime::parse_from_rfc3339(&ban_expires_str)
                .map_err(|_| TetrisError::InvalidInput("Invalid date format".to_string()))?
                .with_timezone(&Utc))
        } else {
            None
        };

        Ok(User {
            id,
            username: row.get("username"),
            email: row.get("email"),
            password_hash: row.get("password_hash"),
            avatar_path: row.get("avatar_path"),
            created_at,
            last_login,
            is_banned: row.get("is_banned"),
            ban_reason: row.get("ban_reason"),
            ban_expires_at,
            rating: row.get::<i64, _>("rating") as u32,
            total_play_time: row.get::<i64, _>("total_play_time") as u64,
            preferences: UserPreferences {
                theme: row.get("preferences_theme"),
                language: row.get("preferences_language"),
                sound_enabled: row.get("preferences_sound_enabled"),
                music_enabled: row.get("preferences_music_enabled"),
                vibration_enabled: row.get("preferences_vibration_enabled"),
                show_ghost_piece: row.get("preferences_show_ghost_piece"),
                show_next_pieces: row.get::<i64, _>("preferences_show_next_pieces") as u8,
                auto_repeat_delay: row.get::<i64, _>("preferences_auto_repeat_delay") as u32,
                auto_repeat_rate: row.get::<i64, _>("preferences_auto_repeat_rate") as u32,
                soft_drop_multiplier: row.get("preferences_soft_drop_multiplier"),
            },
        })
    }
}
