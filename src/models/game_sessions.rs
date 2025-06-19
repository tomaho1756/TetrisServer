// src/models/game_session.rs
use serde::{Deserialize, Serialize};
use uuid::Uuid;
use chrono::{DateTime, Utc};
use std::collections::HashMap;
use super::{GameBoard, GameMode, GameStatus, PlayerAction, TetrominoType, PlayerInfo};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GameSession {
    pub id: Uuid,
    pub room_id: Option<String>,
    pub game_mode: GameMode,
    pub status: GameStatus,
    pub players: Vec<Uuid>,
    pub spectators: Vec<Uuid>,
    pub game_boards: HashMap<Uuid, GameBoard>, // 플레이어별 게임 보드
    pub player_info: HashMap<Uuid, PlayerGameInfo>,
    pub created_at: DateTime<Utc>,
    pub started_at: Option<DateTime<Utc>>,
    pub finished_at: Option<DateTime<Utc>>,
    pub current_turn: Option<Uuid>, // 턴제 게임의 경우
    pub winner: Option<Uuid>,
    pub team_assignments: Option<HashMap<Uuid, u8>>, // 2v2 모드용 팀 배정 (0 또는 1)
    pub game_settings: GameSettings,
    pub match_history: Vec<GameEvent>,
    pub countdown_start: Option<DateTime<Utc>>,
    pub is_ranked: bool,
    pub seed: u64, // 랜덤 시드 (리플레이용)
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlayerGameInfo {
    pub user_id: Uuid,
    pub username: String,
    pub avatar_path: Option<String>,
    pub rating: u32,
    pub is_ready: bool,
    pub is_alive: bool,
    pub placement: Option<u32>, // 게임 내 순위
    pub total_pieces_placed: u32,
    pub total_actions: u32,
    pub attack_sent: u32,
    pub attack_received: u32,
    pub max_combo: u32,
    pub perfect_clears: u32, // PC 횟수
    pub t_spins: u32,
    pub tetrises: u32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GameSettings {
    pub gravity_multiplier: f32,
    pub lock_delay: u32, // 밀리초
    pub line_clear_delay: u32, // 밀리초
    pub garbage_cap: Option<u32>, // 최대 쌓일 수 있는 쓰레기 라인
    pub b2b_bonus: bool,
    pub combo_table: Vec<u32>, // 콤보별 공격 라인 수
    pub allow_hold: bool,
    pub ghost_piece: bool,
    pub next_queue_size: u8,
    pub starting_level: u32,
    pub level_progression: LevelProgression,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum LevelProgression {
    Classic, // 10라인마다 레벨업
    Modern,  // 점수 기반
    Fixed,   // 고정 레벨
}

impl Default for GameSettings {
    fn default() -> Self {
        Self {
            gravity_multiplier: 1.0,
            lock_delay: 500,
            line_clear_delay: 300,
            garbage_cap: Some(12),
            b2b_bonus: true,
            combo_table: vec![0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5], // 콤보 0-11+
            allow_hold: true,
            ghost_piece: true,
            next_queue_size: 5,
            starting_level: 1,
            level_progression: LevelProgression::Classic,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GameEvent {
    pub id: Uuid,
    pub game_id: Uuid,
    pub player_id: Option<Uuid>,
    pub event_type: GameEventType,
    pub timestamp: DateTime<Utc>,
    pub data: serde_json::Value,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum GameEventType {
    GameStart,
    GameEnd,
    PlayerJoin,
    PlayerLeave,
    PlayerReady,
    PlayerAction,
    PiecePlaced,
    LineCleared,
    Attack,
    TopOut, // 게임 오버
    Pause,
    Resume,
    Spectate,
}

impl GameSession {
    pub fn new(game_mode: GameMode, creator_id: Uuid) -> Self {
        let id = Uuid::new_v4();
        let mut players = Vec::new();
        let mut game_boards = HashMap::new();
        let mut player_info = HashMap::new();

        players.push(creator_id);
        game_boards.insert(creator_id, GameBoard::new());
        player_info.insert(creator_id, PlayerGameInfo {
            user_id: creator_id,
            username: "Unknown".to_string(), // 나중에 업데이트
            avatar_path: None,
            rating: 1000,
            is_ready: false,
            is_alive: true,
            placement: None,
            total_pieces_placed: 0,
            total_actions: 0,
            attack_sent: 0,
            attack_received: 0,
            max_combo: 0,
            perfect_clears: 0,
            t_spins: 0,
            tetrises: 0,
        });

        Self {
            id,
            room_id: None,
            game_mode,
            status: GameStatus::Waiting,
            players,
            spectators: Vec::new(),
            game_boards,
            player_info,
            created_at: Utc::now(),
            started_at: None,
            finished_at: None,
            current_turn: Some(creator_id),
            winner: None,
            team_assignments: None,
            game_settings: GameSettings::default(),
            match_history: Vec::new(),
            countdown_start: None,
            is_ranked: false,
            seed: rand::random(),
        }
    }

    // 플레이어 추가
    pub fn add_player(&mut self, player_id: Uuid, player_info: PlayerInfo) -> Result<(), String> {
        if self.status != GameStatus::Waiting {
            return Err("게임이 이미 시작되었습니다.".to_string());
        }

        let max_players = match self.game_mode {
            GameMode::SinglePlayer => 1,
            GameMode::OneVsOne => 2,
            GameMode::TwoVsTwo => 4,
        };

        if self.players.len() >= max_players {
            return Err("게임이 이미 꽉 찼습니다.".to_string());
        }

        if self.players.contains(&player_id) {
            return Err("이미 참가한 플레이어입니다.".to_string());
        }

        self.players.push(player_id);
        self.game_boards.insert(player_id, GameBoard::new());
        self.player_info.insert(player_id, PlayerGameInfo {
            user_id: player_id,
            username: player_info.username,
            avatar_path: player_info.avatar_path,
            rating: player_info.rating.unwrap_or(1000),
            is_ready: false,
            is_alive: true,
            placement: None,
            total_pieces_placed: 0,
            total_actions: 0,
            attack_sent: 0,
            attack_received: 0,
            max_combo: 0,
            perfect_clears: 0,
            t_spins: 0,
            tetrises: 0,
        });

        // 2v2 모드인 경우 팀 배정
        if self.game_mode == GameMode::TwoVsTwo {
            if self.team_assignments.is_none() {
                self.team_assignments = Some(HashMap::new());
            }

            if let Some(ref mut teams) = self.team_assignments {
                let team = if self.players.len() <= 2 { 0 } else { 1 };
                teams.insert(player_id, team);
            }
        }

        // 이벤트 기록
        self.add_event(GameEventType::PlayerJoin, Some(player_id), serde_json::json!({
            "username": player_info.username,
            "rating": player_info.rating
        }));

        Ok(())
    }

    // 관전자 추가
    pub fn add_spectator(&mut self, spectator_id: Uuid) -> Result<(), String> {
        if self.spectators.contains(&spectator_id) {
            return Err("이미 관전 중입니다.".to_string());
        }

        if self.players.contains(&spectator_id) {
            return Err("이미 게임에 참가 중입니다.".to_string());
        }

        self.spectators.push(spectator_id);

        self.add_event(GameEventType::Spectate, Some(spectator_id), serde_json::json!({}));

        Ok(())
    }

    // 플레이어 준비 상태 설정
    pub fn set_player_ready(&mut self, player_id: Uuid, ready: bool) -> Result<(), String> {
        if !self.players.contains(&player_id) {
            return Err("게임에 참가하지 않은 플레이어입니다.".to_string());
        }

        if let Some(info) = self.player_info.get_mut(&player_id) {
            info.is_ready = ready;

            self.add_event(GameEventType::PlayerReady, Some(player_id), serde_json::json!({
                "ready": ready
            }));
        }

        Ok(())
    }

    // 모든 플레이어가 준비됐는지 확인
    pub fn all_players_ready(&self) -> bool {
        self.players.iter().all(|&player_id| {
            self.player_info.get(&player_id)
                .map(|info| info.is_ready)
                .unwrap_or(false)
        })
    }

    // 게임 시작
    pub fn start_game(&mut self) -> Result<(), String> {
        if self.status != GameStatus::Waiting {
            return Err("게임을 시작할 수 없습니다.".to_string());
        }

        let required_players = match self.game_mode {
            GameMode::SinglePlayer => 1,
            GameMode::OneVsOne => 2,
            GameMode::TwoVsTwo => 4,
        };

        if self.players.len() != required_players {
            return Err(format!("{}명의 플레이어가 필요합니다.", required_players));
        }

        if !self.all_players_ready() && self.game_mode != GameMode::SinglePlayer {
            return Err("모든 플레이어가 준비되지 않았습니다.".to_string());
        }

        self.status = GameStatus::Playing;
        self.started_at = Some(Utc::now());

        // 모든 플레이어의 게임 보드 초기화 (같은 시드 사용)
        for &player_id in &self.players {
            if let Some(board) = self.game_boards.get_mut(&player_id) {
                *board = GameBoard::new();
                // TODO: 시드 기반 피스 시퀀스 설정
            }
        }

        self.add_event(GameEventType::GameStart, None, serde_json::json!({
            "players": self.players,
            "game_mode": self.game_mode,
            "seed": self.seed
        }));

        Ok(())
    }

    // 카운트다운 시작
    pub fn start_countdown(&mut self, duration_seconds: u32) {
        self.countdown_start = Some(Utc::now());
        // 카운트다운 후 자동 시작하는 로직은 별도 구현 필요
    }

    // 플레이어 액션 처리
    pub fn handle_player_action(&mut self, player_id: Uuid, action: PlayerAction) -> Result<bool, String> {
        if self.status != GameStatus::Playing {
            return Err("게임이 진행 중이 아닙니다.".to_string());
        }

        if !self.players.contains(&player_id) {
            return Err("게임에 참가하지 않은 플레이어입니다.".to_string());
        }

        // 플레이어가 아직 살아있는지 확인
        if let Some(info) = self.player_info.get(&player_id) {
            if !info.is_alive {
                return Err("이미 게임 오버된 플레이어입니다.".to_string());
            }
        }

        let board = self.game_boards.get_mut(&player_id)
            .ok_or("플레이어의 게임 보드를 찾을 수 없습니다.")?;

        // 액션 실행 전 상태 저장
        let lines_before = board.lines_cleared;
        let combo_before = board.combo_count;

        let result = match action {
            PlayerAction::MoveLeft => board.move_left(),
            PlayerAction::MoveRight => board.move_right(),
            PlayerAction::MoveDown => board.soft_drop(),
            PlayerAction::Rotate => board.rotate(),
            PlayerAction::HardDrop => {
                let drop_distance = board.hard_drop();
                drop_distance > 0
            },
            PlayerAction::Hold => board.hold(),
        };

        // 액션 통계 업데이트
        if let Some(info) = self.player_info.get_mut(&player_id) {
            info.total_actions += 1;

            // 피스 배치 감지
            if let PlayerAction::HardDrop = action {
                info.total_pieces_placed += 1;
            }

            // 라인 클리어 감지
            let lines_cleared = board.lines_cleared - lines_before;
            if lines_cleared > 0 {
                info.max_combo = info.max_combo.max(board.combo_count);

                // 특별한 클리어 감지
                if lines_cleared == 4 {
                    info.tetrises += 1;
                }

                // 공격 라인 계산 및 전송
                let is_t_spin = false; // TODO: T-spin 감지 로직
                let attack_lines = board.calculate_attack_lines(lines_cleared, is_t_spin);

                if attack_lines > 0 {
                    self.send_attack_to_opponents(player_id, attack_lines)?;
                    info.attack_sent += attack_lines;
                }
            }
        }

        // 이벤트 기록
        self.add_event(GameEventType::PlayerAction, Some(player_id), serde_json::json!({
            "action": action,
            "result": result,
            "lines_cleared": board.lines_cleared - lines_before
        }));

        // 게임 오버 체크
        if board.is_game_over() {
            self.handle_player_game_over(player_id)?;
        }

        Ok(result)
    }

    // 상대방에게 공격 라인 전송
    fn send_attack_to_opponents(&mut self, attacker_id: Uuid, attack_lines: u32) -> Result<(), String> {
        match self.game_mode {
            GameMode::SinglePlayer => {
                // 싱글플레이어는 공격 없음
            },
            GameMode::OneVsOne => {
                // 상대방 찾기
                if let Some(&opponent_id) = self.players.iter().find(|&&id| id != attacker_id) {
                    if let Some(opponent_board) = self.game_boards.get_mut(&opponent_id) {
                        opponent_board.attack_queue.push_back(attack_lines);

                        if let Some(info) = self.player_info.get_mut(&opponent_id) {
                            info.attack_received += attack_lines;
                        }
                    }
                }
            },
            GameMode::TwoVsTwo => {
                // 팀 게임: 상대 팀에게 공격 분산
                if let Some(ref teams) = self.team_assignments {
                    if let Some(&attacker_team) = teams.get(&attacker_id) {
                        let opponent_team = 1 - attacker_team;

                        let opponents: Vec<&Uuid> = teams.iter()
                            .filter(|(_, &team)| team == opponent_team)
                            .map(|(id, _)| id)
                            .collect();

                        let attack_per_opponent = attack_lines / opponents.len() as u32;
                        let remaining_attack = attack_lines % opponents.len() as u32;

                        for (i, &opponent_id) in opponents.iter().enumerate() {
                            let attack_amount = attack_per_opponent +
                                if i < remaining_attack as usize { 1 } else { 0 };

                            if let Some(opponent_board) = self.game_boards.get_mut(opponent_id) {
                                opponent_board.attack_queue.push_back(attack_amount);

                                if let Some(info) = self.player_info.get_mut(opponent_id) {
                                    info.attack_received += attack_amount;
                                }
                            }
                        }
                    }
                }
            },
        }

        self.add_event(GameEventType::Attack, Some(attacker_id), serde_json::json!({
            "attack_lines": attack_lines
        }));

        Ok(())
    }

    // 플레이어 게임 오버 처리
    fn handle_player_game_over(&mut self, player_id: Uuid) -> Result<(), String> {
        // 플레이어를 사망 상태로 변경
        if let Some(info) = self.player_info.get_mut(&player_id) {
            info.is_alive = false;
        }

        self.add_event(GameEventType::TopOut, Some(player_id), serde_json::json!({}));

        match self.game_mode {
            GameMode::SinglePlayer => {
                self.finish_game(None);
            },
            GameMode::OneVsOne => {
                // 상대방이 승리
                let winner = self.players.iter()
                    .find(|&&id| id != player_id)
                    .copied();
                self.finish_game(winner);
            },
            GameMode::TwoVsTwo => {
                // 팀 게임 로직 구현
                self.handle_team_game_over(player_id)?;
            },
        }
        Ok(())
    }

    // 2v2 게임 오버 처리
    fn handle_team_game_over(&mut self, eliminated_player: Uuid) -> Result<(), String> {
        let teams = self.team_assignments.as_ref()
            .ok_or("팀 배정 정보가 없습니다.")?;

        let eliminated_team = teams.get(&eliminated_player)
            .ok_or("플레이어의 팀 정보를 찾을 수 없습니다.")?;

        // 같은 팀의 다른 플레이어가 살아있는지 확인
        let team_alive = teams.iter()
            .filter(|(_, &team)| team == *eliminated_team)
            .any(|(&player_id, _)| {
                player_id != eliminated_player &&
                    self.player_info.get(&player_id)
                        .map(|info| info.is_alive)
                        .unwrap_or(false)
            });

        if !team_alive {
            // 팀 전체가 게임 오버, 상대 팀에서 승자 결정
            let winning_team = 1 - eliminated_team;
            let winner = teams.iter()
                .filter(|(_, &team)| team == winning_team)
                .filter_map(|(&player_id, _)| {
                    if self.player_info.get(&player_id)?.is_alive {
                        Some(player_id)
                    } else {
                        None
                    }
                })
                .next();

            self.finish_game(winner);
        }

        Ok(())
    }

    // 게임 종료
    pub fn finish_game(&mut self, winner: Option<Uuid>) {
        self.status = GameStatus::Finished;
        self.finished_at = Some(Utc::now());
        self.winner = winner;

        // 플레이어 순위 계산
        self.calculate_final_rankings();

        self.add_event(GameEventType::GameEnd, winner, serde_json::json!({
            "winner": winner,
            "duration": self.get_duration().map(|d| d.num_seconds())
        }));
    }

    // 최종 순위 계산
    fn calculate_final_rankings(&mut self) {
        let mut player_scores: Vec<(Uuid, u32)> = self.players.iter()
            .map(|&player_id| {
                let score = self.game_boards.get(&player_id)
                    .map(|board| board.score)
                    .unwrap_or(0);
                (player_id, score)
            })
            .collect();

        // 점수 기준으로 정렬 (높은 점수가 우선)
        player_scores.sort_by(|a, b| b.1.cmp(&a.1));

        // 순위 배정
        for (rank, (player_id, _)) in player_scores.iter().enumerate() {
            if let Some(info) = self.player_info.get_mut(player_id) {
                info.placement = Some((rank + 1) as u32);
            }
        }
    }

    // 게임 일시정지
    pub fn pause_game(&mut self) -> Result<(), String> {
        if self.status != GameStatus::Playing {
            return Err("진행 중인 게임만 일시정지할 수 있습니다.".to_string());
        }

        self.status = GameStatus::Paused;
        self.add_event(GameEventType::Pause, None, serde_json::json!({}));
        Ok(())
    }

    // 게임 재개
    pub fn resume_game(&mut self) -> Result<(), String> {
        if self.status != GameStatus::Paused {
            return Err("일시정지된 게임만 재개할 수 있습니다.".to_string());
        }

        self.status = GameStatus::Playing;
        self.add_event(GameEventType::Resume, None, serde_json::json!({}));
        Ok(())
    }

    // 플레이어 제거
    pub fn remove_player(&mut self, player_id: Uuid) -> Result<(), String> {
        if !self.players.contains(&player_id) {
            return Err("게임에 참가하지 않은 플레이어입니다.".to_string());
        }

        self.players.retain(|&id| id != player_id);
        self.game_boards.remove(&player_id);
        self.player_info.remove(&player_id);

        if let Some(ref mut teams) = self.team_assignments {
            teams.remove(&player_id);
        }

        self.add_event(GameEventType::PlayerLeave, Some(player_id), serde_json::json!({}));

        // 게임이 진행 중이고 플레이어가 부족해지면 게임 종료
        if self.status == GameStatus::Playing && self.players.len() < 2 && self.game_mode != GameMode::SinglePlayer {
            let winner = self.players.first().copied();
            self.finish_game(winner);
        }

        Ok(())
    }

    // 관전자 제거
    pub fn remove_spectator(&mut self, spectator_id: Uuid) -> Result<(), String> {
        if !self.spectators.contains(&spectator_id) {
            return Err("관전하지 않고 있습니다.".to_string());
        }

        self.spectators.retain(|&id| id != spectator_id);
        Ok(())
    }

    // 게임 지속 시간 계산
    pub fn get_duration(&self) -> Option<chrono::Duration> {
        if let Some(started) = self.started_at {
            let end_time = self.finished_at.unwrap_or_else(Utc::now);
            Some(end_time - started)
        } else {
            None
        }
    }

    // 이벤트 추가
    fn add_event(&mut self, event_type: GameEventType, player_id: Option<Uuid>, data: serde_json::Value) {
        let event = GameEvent {
            id: Uuid::new_v4(),
            game_id: self.id,
            player_id,
            event_type,
            timestamp: Utc::now(),
            data,
        };
        self.match_history.push(event);
    }

    // 게임 리플레이 데이터 생성
    pub fn generate_replay_data(&self) -> serde_json::Value {
        serde_json::json!({
            "game_id": self.id,
            "game_mode": self.game_mode,
            "players": self.player_info,
            "settings": self.game_settings,
            "seed": self.seed,
            "events": self.match_history,
            "duration": self.get_duration().map(|d| d.num_seconds()),
            "winner": self.winner
        })
    }

    // 현재 게임 상태 요약
    pub fn get_status_summary(&self) -> serde_json::Value {
        serde_json::json!({
            "id": self.id,
            "status": self.status,
            "game_mode": self.game_mode,
            "players": self.players.len(),
            "spectators": self.spectators.len(),
            "started_at": self.started_at,
            "duration": self.get_duration().map(|d| d.num_seconds()),
            "is_ranked": self.is_ranked
        })
    }
}