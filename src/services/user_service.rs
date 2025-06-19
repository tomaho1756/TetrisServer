// src/services/user_service.rs
use crate::database::Database;
use crate::models::*;
use uuid::Uuid;
use bcrypt::{hash, verify, DEFAULT_COST};
use jsonwebtoken::{encode, decode, Header, Algorithm, Validation, EncodingKey, DecodingKey};
use serde::{Deserialize, Serialize};
use chrono::{DateTime, Utc, Duration};
use std::collections::HashMap;

#[derive(Debug, Serialize, Deserialize)]
struct Claims {
    sub: String, // user_id
    exp: usize,  // expiration
    iat: usize,  // issued at
}

#[derive(Clone)]
pub struct UserService {
    db: Database,
    jwt_secret: String,
}

impl UserService {
    pub fn new(db: Database) -> Self {
        let jwt_secret = std::env::var("JWT_SECRET")
            .unwrap_or_else(|_| "tetris-super-secret-key-2024-change-me-in-production".to_string());

        Self {
            db,
            jwt_secret,
        }
    }

    // 사용자 등록
    pub async fn register_user(
        &self,
        username: String,
        email: String,
        password: String,
    ) -> Result<User> {
        // 입력 유효성 검사
        self.validate_registration_input(&username, &email, &password)?;

        // 이메일 중복 확인
        if let Some(_) = self.db.get_user_by_email(&email).await? {
            return Err(TetrisError::Authentication("이미 존재하는 이메일입니다.".to_string()));
        }

        // 사용자명 중복 확인
        if let Some(_) = self.db.get_user_by_username(&username).await? {
            return Err(TetrisError::Authentication("이미 존재하는 사용자명입니다.".to_string()));
        }

        // 비밀번호 해시화
        let password_hash = hash(password, DEFAULT_COST)
            .map_err(|_| TetrisError::Authentication("비밀번호 해시화 실패".to_string()))?;

        // 사용자 생성
        let user = User::new(username.trim().to_string(), email.trim().to_lowercase(), password_hash);

        // 데이터베이스에 저장
        self.db.create_user(&user).await?;

        // 기본 도전과제 생성
        self.create_default_achievements(user.id).await?;

        println!("👤 새 사용자 등록: {} ({})", user.username, user.email);
        Ok(user)
    }

    // 등록 입력 검증
    fn validate_registration_input(&self, username: &str, email: &str, password: &str) -> Result<()> {
        // 사용자명 검증
        if username.trim().is_empty() {
            return Err(TetrisError::InvalidInput("사용자명이 비어있습니다.".to_string()));
        }

        if username.len() < 2 || username.len() > 20 {
            return Err(TetrisError::InvalidInput("사용자명은 2-20자여야 합니다.".to_string()));
        }

        if !username.chars().all(|c| c.is_alphanumeric() || c == '_' || c == '-') {
            return Err(TetrisError::InvalidInput("사용자명은 영문, 숫자, _, -만 사용 가능합니다.".to_string()));
        }

        // 이메일 검증
        if email.trim().is_empty() || !email.contains('@') || !email.contains('.') {
            return Err(TetrisError::InvalidInput("유효하지 않은 이메일입니다.".to_string()));
        }

        // 비밀번호 검증
        if password.len() < 6 {
            return Err(TetrisError::InvalidInput("비밀번호는 6자 이상이어야 합니다.".to_string()));
        }

        if password.len() > 128 {
            return Err(TetrisError::InvalidInput("비밀번호는 128자 이하여야 합니다.".to_string()));
        }

        Ok(())
    }

    // 사용자 로그인
    pub async fn login_user(&self, email: String, password: String) -> Result<(User, String)> {
        // 입력 유효성 검사
        if email.trim().is_empty() {
            return Err(TetrisError::InvalidInput("이메일이 비어있습니다.".to_string()));
        }
        if password.is_empty() {
            return Err(TetrisError::InvalidInput("비밀번호가 비어있습니다.".to_string()));
        }

        // 사용자 조회
        let user = self.db.get_user_by_email(&email.trim().to_lowercase()).await?
            .ok_or_else(|| TetrisError::Authentication("존재하지 않는 이메일입니다.".to_string()))?;

        // 밴 확인
        if user.is_currently_banned() {
            let ban_info = if let Some(expires) = user.ban_expires_at {
                format!("{}까지 정지됨. 사유: {}",
                        expires.format("%Y-%m-%d %H:%M"),
                        user.ban_reason.as_deref().unwrap_or("규정 위반")
                )
            } else {
                format!("영구 정지됨. 사유: {}",
                        user.ban_reason.as_deref().unwrap_or("규정 위반")
                )
            };
            return Err(TetrisError::Authentication(ban_info));
        }

        // 비밀번호 검증
        if !verify(password, &user.password_hash)
            .map_err(|_| TetrisError::Authentication("비밀번호 검증 실패".to_string()))? {
            return Err(TetrisError::Authentication("잘못된 비밀번호입니다.".to_string()));
        }

        // 마지막 로그인 시간 업데이트
        self.db.update_last_login(user.id).await?;

        // JWT 토큰 생성
        let token = self.generate_jwt_token(user.id)?;

        println!("🔐 사용자 로그인: {} ({})", user.username, user.email);
        Ok((user, token))
    }

    // JWT 토큰 생성
    pub fn generate_jwt_token(&self, user_id: Uuid) -> Result<String> {
        let now = Utc::now();
        let exp = (now + Duration::hours(24)).timestamp() as usize;
        let iat = now.timestamp() as usize;

        let claims = Claims {
            sub: user_id.to_string(),
            exp,
            iat,
        };

        let token = encode(
            &Header::default(),
            &claims,
            &EncodingKey::from_secret(self.jwt_secret.as_ref()),
        ).map_err(|_| TetrisError::Authentication("토큰 생성 실패".to_string()))?;

        Ok(token)
    }

    // JWT 토큰 검증
    pub fn verify_jwt_token(&self, token: &str) -> Result<Uuid> {
        let validation = Validation::new(Algorithm::HS256);

        let token_data = decode::<Claims>(
            token,
            &DecodingKey::from_secret(self.jwt_secret.as_ref()),
            &validation,
        ).map_err(|_| TetrisError::Authentication("유효하지 않은 토큰".to_string()))?;

        let user_id = Uuid::parse_str(&token_data.claims.sub)
            .map_err(|_| TetrisError::Authentication("잘못된 사용자 ID".to_string()))?;

        Ok(user_id)
    }

    // 사용자 정보 조회
    pub async fn get_user_by_id(&self, user_id: Uuid) -> Result<Option<User>> {
        match self.db.get_user_by_id(user_id).await {
            Ok(user) => Ok(Some(user)),
            Err(TetrisError::Database(sqlx::Error::RowNotFound)) => Ok(None),
            Err(e) => Err(e),
        }
    }

    // 사용자 프로필 조회
    pub async fn get_user_profile(&self, user_id: Uuid) -> Result<UserProfile> {
        let user = self.db.get_user_by_id_required(user_id).await?;
        let stats = self.calculate_user_stats(user_id).await?;
        let recent_games = self.db.get_user_recent_games(user_id, 10).await?;
        let achievements = self.db.get_user_achievements(user_id).await?;
        let friends = self.get_user_friends(user_id).await?;

        Ok(UserProfile {
            user,
            stats,
            recent_games,
            achievements,
            friends,
        })
    }

    // 사용자 통계 계산
    async fn calculate_user_stats(&self, user_id: Uuid) -> Result<UserStats> {
        let game_stats = self.db.get_user_game_stats(user_id).await?;

        if game_stats.is_empty() {
            return Ok(UserStats::default());
        }

        let total_games = game_stats.len() as u32;
        let wins = game_stats.iter().filter(|g| g.is_victory).count() as u32;
        let losses = total_games - wins;
        let highest_score = game_stats.iter().map(|g| g.score).max().unwrap_or(0);
        let total_lines_cleared = game_stats.iter().map(|g| g.lines_cleared).sum();
        let total_score: u32 = game_stats.iter().map(|g| g.score).sum();
        let average_score = if total_games > 0 { total_score as f32 / total_games as f32 } else { 0.0 };
        let total_play_time = game_stats.iter().map(|g| g.duration).sum();

        // 가장 많이 플레이한 게임 모드 계산
        let mut mode_counts = HashMap::new();
        for stat in &game_stats {
            *mode_counts.entry(&stat.game_mode).or_insert(0) += 1;
        }
        let favorite_mode = mode_counts.into_iter()
            .max_by_key(|(_, count)| *count)
            .map(|(mode, _)| mode.clone());

        // 최고 PPS/APM
        let best_pps = game_stats.iter().map(|g| g.pps).fold(0.0f32, f32::max);
        let best_apm = game_stats.iter().map(|g| g.apm).fold(0.0f32, f32::max);

        // 평균 순위 (멀티플레이어)
        let placements: Vec<u32> = game_stats.iter()
            .filter_map(|g| g.placement)
            .collect();
        let average_placement = if !placements.is_empty() {
            placements.iter().sum::<u32>() as f32 / placements.len() as f32
        } else {
            0.0
        };

        // 승률
        let win_rate = if total_games > 0 { wins as f32 / total_games as f32 } else { 0.0 };

        // 현재 연승/연패
        let current_streak = self.calculate_current_streak(&game_stats);
        let best_streak = self.calculate_best_streak(&game_stats);

        Ok(UserStats {
            total_games,
            wins,
            losses,
            highest_score,
            total_lines_cleared,
            average_score,
            total_play_time,
            favorite_mode,
            best_pps,
            best_apm,
            average_placement,
            win_rate,
            current_streak,
            best_streak,
        })
    }

    // 현재 연승 계산
    fn calculate_current_streak(&self, game_stats: &[GameStats]) -> u32 {
        let mut streak = 0;

        // 최신 게임부터 역순으로 확인
        for game in game_stats.iter().rev() {
            if game.is_victory {
                streak += 1;
            } else {
                break;
            }
        }

        streak
    }

    // 최고 연승 계산
    fn calculate_best_streak(&self, game_stats: &[GameStats]) -> u32 {
        let mut best_streak = 0;
        let mut current_streak = 0;

        for game in game_stats {
            if game.is_victory {
                current_streak += 1;
                best_streak = best_streak.max(current_streak);
            } else {
                current_streak = 0;
            }
        }

        best_streak
    }

    // 게임 통계 저장
    pub async fn save_game_stats(&self, stats: &GameStats) -> Result<()> {
        self.db.save_game_stats(stats).await?;

        // 도전과제 확인
        self.check_achievements(stats.user_id, stats).await?;

        // 레이팅 업데이트 (랭크 게임의 경우)
        // TODO: 구현 필요

        Ok(())
    }

    // 리더보드 조회
    pub async fn get_leaderboard(&self, limit: i32) -> Result<Vec<UserStatsResponse>> {
        let top_users = self.db.get_top_users_by_score(limit).await?;
        let mut leaderboard = Vec::new();

        for (user, highest_score) in top_users {
            let stats = self.calculate_user_stats(user.id).await?;
            leaderboard.push(UserStatsResponse {
                user_id: user.id.to_string(),
                username: user.username,
                total_games: stats.total_games,
                wins: stats.wins,
                losses: stats.losses,
                highest_score,
                total_lines_cleared: stats.total_lines_cleared,
                average_score: stats.average_score,
            });
        }

        Ok(leaderboard)
    }

    // 사용자 프로필 업데이트
    pub async fn update_user_profile(
        &self,
        user_id: Uuid,
        username: Option<String>,
        avatar_path: Option<String>,
    ) -> Result<User> {
        // 사용자명 중복 확인 (변경하려는 경우)
        if let Some(ref new_username) = username {
            if let Some(existing_user) = self.db.get_user_by_username(new_username).await? {
                if existing_user.id != user_id {
                    return Err(TetrisError::Authentication("이미 존재하는 사용자명입니다.".to_string()));
                }
            }
        }

        self.db.update_user_profile(user_id, username, avatar_path).await
    }

    // 비밀번호 변경
    pub async fn change_password(
        &self,
        user_id: Uuid,
        current_password: String,
        new_password: String,
    ) -> Result<()> {
        let user = self.db.get_user_by_id_required(user_id).await?;

        // 현재 비밀번호 검증
        if !verify(current_password, &user.password_hash)
            .map_err(|_| TetrisError::Authentication("비밀번호 검증 실패".to_string()))? {
            return Err(TetrisError::Authentication("현재 비밀번호가 일치하지 않습니다.".to_string()));
        }

        // 새 비밀번호 유효성 검사
        if new_password.len() < 6 {
            return Err(TetrisError::InvalidInput("새 비밀번호는 6자 이상이어야 합니다.".to_string()));
        }

        // 새 비밀번호 해시화
        let new_password_hash = hash(new_password, DEFAULT_COST)
            .map_err(|_| TetrisError::Authentication("비밀번호 해시화 실패".to_string()))?;

        self.db.update_user_password(user_id, new_password_hash).await
    }

    // 계정 삭제
    pub async fn delete_user(&self, user_id: Uuid, password: String) -> Result<()> {
        let user = self.db.get_user_by_id_required(user_id).await?;

        // 비밀번호 검증
        if !verify(password, &user.password_hash)
            .map_err(|_| TetrisError::Authentication("비밀번호 검증 실패".to_string()))? {
            return Err(TetrisError::Authentication("비밀번호가 일치하지 않습니다.".to_string()));
        }

        self.db.delete_user(user_id).await
    }

    // 친구 목록 조회
    pub async fn get_user_friends(&self, user_id: Uuid) -> Result<Vec<Friend>> {
        self.db.get_user_friends(user_id).await
    }

    // 친구 요청 전송
    pub async fn send_friend_request(&self, from_user_id: Uuid, to_user_id: Uuid, message: Option<String>) -> Result<()> {
        // 자기 자신에게 친구 요청 불가
        if from_user_id == to_user_id {
            return Err(TetrisError::InvalidInput("자기 자신에게 친구 요청을 보낼 수 없습니다.".to_string()));
        }

        // 이미 친구인지 확인
        if self.db.are_friends(from_user_id, to_user_id).await? {
            return Err(TetrisError::InvalidInput("이미 친구입니다.".to_string()));
        }

        // 이미 친구 요청이 있는지 확인
        if self.db.has_pending_friend_request(from_user_id, to_user_id).await? {
            return Err(TetrisError::InvalidInput("이미 친구 요청을 보냈습니다.".to_string()));
        }

        self.db.create_friend_request(from_user_id, to_user_id, message).await
    }

    // 친구 요청 수락
    pub async fn accept_friend_request(&self, request_id: String) -> Result<()> {
        self.db.accept_friend_request(request_id).await
    }

    // 친구 요청 거절
    pub async fn decline_friend_request(&self, request_id: String) -> Result<()> {
        self.db.decline_friend_request(request_id).await
    }

    // 친구 제거
    pub async fn remove_friend(&self, user_id: Uuid, friend_id: Uuid) -> Result<()> {
        self.db.remove_friend(user_id, friend_id).await
    }

    // 사용자 밴
    pub async fn ban_user(
        &self,
        admin_id: Uuid,
        target_id: Uuid,
        reason: String,
        duration: Option<Duration>,
    ) -> Result<()> {
        // 관리자 권한 확인
        let admin = self.db.get_user_by_id_required(admin_id).await?;
        if !self.db.is_admin(admin_id).await? {
            return Err(TetrisError::Unauthorized);
        }

        let ban_expires_at = duration.map(|d| Utc::now() + d);

        self.db.ban_user(target_id, reason, ban_expires_at).await?;

        println!("🚫 사용자 밴: {} (관리자: {})", target_id, admin.username);
        Ok(())
    }

    // 사용자 밴 해제
    pub async fn unban_user(&self, admin_id: Uuid, target_id: Uuid) -> Result<()> {
        // 관리자 권한 확인
        if !self.db.is_admin(admin_id).await? {
            return Err(TetrisError::Unauthorized);
        }

        self.db.unban_user(target_id).await?;

        println!("✅ 사용자 밴 해제: {}", target_id);
        Ok(())
    }

    // 기본 도전과제 생성
    async fn create_default_achievements(&self, user_id: Uuid) -> Result<()> {
        let default_achievements = vec![
            Achievement {
                id: "first_game".to_string(),
                name: "첫 게임".to_string(),
                description: "첫 번째 게임을 완료하세요".to_string(),
                icon: "🎮".to_string(),
                unlocked_at: None,
                progress: 0,
                target: 1,
                category: AchievementCategory::Games,
                rarity: AchievementRarity::Common,
            },
            Achievement {
                id: "first_tetris".to_string(),
                name: "첫 테트리스".to_string(),
                description: "첫 번째 테트리스를 완성하세요".to_string(),
                icon: "🏆".to_string(),
                unlocked_at: None,
                progress: 0,
                target: 1,
                category: AchievementCategory::Skill,
                rarity: AchievementRarity::Uncommon,
            },
            // 더 많은 도전과제 추가...
        ];

        for achievement in default_achievements {
            self.db.create_user_achievement(user_id, &achievement).await?;
        }

        Ok(())
    }

    // 도전과제 확인
    async fn check_achievements(&self, user_id: Uuid, game_stats: &GameStats) -> Result<()> {
        // TODO: 게임 통계를 기반으로 도전과제 진행도 업데이트
        Ok(())
    }

    // 관리자 통계 조회
    pub async fn get_admin_stats(&self, requester_id: Uuid) -> Result<AdminStats> {
        // 관리자 권한 확인
        if !self.db.is_admin(requester_id).await? {
            return Err(TetrisError::Unauthorized);
        }

        let total_users = self.db.get_total_users_count().await?;
        let online_users = 0; // TODO: WebSocket 서비스에서 가져오기
        let active_games = 0; // TODO: 게임 서비스에서 가져오기
        let total_games_played = self.db.get_total_games_count().await?;
        let active_rooms = 0; // TODO: 방 서비스에서 가져오기
        let server_uptime = 0; // TODO: 서버 시작 시간부터 계산
        let top_players = self.get_leaderboard(10).await?;

        Ok(AdminStats {
            total_users,
            online_users,
            active_games,
            total_games_played,
            active_rooms,
            server_uptime,
            top_players,
        })
    }

    // 사용자 검색
    pub async fn search_users(&self, query: String, limit: i32) -> Result<Vec<User>> {
        if query.len() < 2 {
            return Err(TetrisError::InvalidInput("검색어는 2자 이상이어야 합니다.".to_string()));
        }

        self.db.search_users(&query, limit).await
    }

    // 사용자 설정 업데이트
    pub async fn update_user_preferences(
        &self,
        user_id: Uuid,
        preferences: UserPreferences,
    ) -> Result<()> {
        self.db.update_user_preferences(user_id, &preferences).await
    }
}