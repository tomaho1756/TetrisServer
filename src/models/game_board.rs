// src/models/game_board.rs
use serde::{Deserialize, Serialize};
use super::{Tetromino, TetrominoType, Position};
use std::collections::VecDeque;
use rand::seq::SliceRandom;
use rand::thread_rng;

pub const BOARD_WIDTH: usize = 10;
pub const BOARD_HEIGHT: usize = 20;
pub const BOARD_BUFFER: usize = 4; // 보이지 않는 상단 버퍼
pub const SPAWN_X: i32 = 4;
pub const SPAWN_Y: i32 = 0;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GameBoard {
    pub grid: Vec<Vec<Option<TetrominoType>>>, // None = 빈칸, Some(type) = 해당 타입의 블록
    pub current_piece: Option<Tetromino>,
    pub next_pieces: VecDeque<TetrominoType>, // 7-bag 시스템용
    pub held_piece: Option<TetrominoType>,
    pub can_hold: bool, // 홀드 기능 사용 가능 여부
    pub score: u32,
    pub level: u32,
    pub lines_cleared: u32,
    pub fall_time: u64, // 밀리초 단위
    pub last_fall_time: u64, // 마지막 자동 낙하 시간
    pub combo_count: u32, // 연속 라인 클리어 수
    pub back_to_back: bool, // B2B (테트리스 또는 T-spin)
    pub garbage_lines: Vec<Vec<Option<TetrominoType>>>, // 공격받은 쓰레기 라인
    pub attack_queue: VecDeque<u32>, // 받을 공격 라인 수
}

impl GameBoard {
    pub fn new() -> Self {
        let mut board = Self {
            grid: vec![vec![None; BOARD_WIDTH]; BOARD_HEIGHT + BOARD_BUFFER],
            current_piece: None,
            next_pieces: VecDeque::new(),
            held_piece: None,
            can_hold: true,
            score: 0,
            level: 1,
            lines_cleared: 0,
            fall_time: 1000, // 1초
            last_fall_time: 0,
            combo_count: 0,
            back_to_back: false,
            garbage_lines: Vec::new(),
            attack_queue: VecDeque::new(),
        };

        // 7-bag 시스템으로 다음 피스들 생성
        board.refill_next_pieces();
        board.spawn_next_piece();

        board
    }

    // 7-bag 시스템: 7개 피스를 섞어서 큐에 추가
    fn refill_next_pieces(&mut self) {
        let mut bag = vec![
            TetrominoType::I,
            TetrominoType::O,
            TetrominoType::T,
            TetrominoType::S,
            TetrominoType::Z,
            TetrominoType::J,
            TetrominoType::L,
        ];

        bag.shuffle(&mut thread_rng());
        for piece in bag {
            self.next_pieces.push_back(piece);
        }
    }

    // 다음 피스 스폰
    fn spawn_next_piece(&mut self) {
        if self.next_pieces.len() < 7 {
            self.refill_next_pieces();
        }

        if let Some(piece_type) = self.next_pieces.pop_front() {
            self.current_piece = Some(Tetromino::new(piece_type, SPAWN_X, SPAWN_Y));
            self.can_hold = true;
        }
    }

    // 다음 N개 피스 미리보기
    pub fn get_next_pieces(&self, count: usize) -> Vec<TetrominoType> {
        self.next_pieces.iter().take(count).copied().collect()
    }

    // 테트로미노가 유효한 위치에 있는지 확인
    pub fn is_valid_position(&self, tetromino: &Tetromino) -> bool {
        for pos in tetromino.get_occupied_positions() {
            // 게임 보드 경계 체크
            if pos.x < 0 || pos.x >= BOARD_WIDTH as i32 ||
                pos.y < 0 || pos.y >= (BOARD_HEIGHT + BOARD_BUFFER) as i32 {
                return false;
            }

            // 이미 블록이 있는지 체크
            if self.grid[pos.y as usize][pos.x as usize].is_some() {
                return false;
            }
        }
        true
    }

    // 테트로미노를 왼쪽으로 이동
    pub fn move_left(&mut self) -> bool {
        if let Some(ref mut piece) = self.current_piece {
            let mut test_piece = piece.clone();
            test_piece.move_by(-1, 0);

            if self.is_valid_position(&test_piece) {
                piece.move_by(-1, 0);
                return true;
            }
        }
        false
    }

    // 테트로미노를 오른쪽으로 이동
    pub fn move_right(&mut self) -> bool {
        if let Some(ref mut piece) = self.current_piece {
            let mut test_piece = piece.clone();
            test_piece.move_by(1, 0);

            if self.is_valid_position(&test_piece) {
                piece.move_by(1, 0);
                return true;
            }
        }
        false
    }

    // 테트로미노를 아래로 이동
    pub fn move_down(&mut self) -> bool {
        if let Some(ref mut piece) = self.current_piece {
            let mut test_piece = piece.clone();
            test_piece.move_by(0, 1);

            if self.is_valid_position(&test_piece) {
                piece.move_by(0, 1);
                return true;
            }
        }
        false
    }

    // 테트로미노 회전 (SRS 적용)
    pub fn rotate(&mut self) -> bool {
        if let Some(ref mut piece) = self.current_piece {
            let original_rotation = piece.rotation;
            let target_rotation = (original_rotation + 1) % 4;

            // 킥 오프셋 시도
            let kick_offsets = piece.get_kick_offsets(original_rotation, target_rotation);

            for (dx, dy) in kick_offsets {
                let mut test_piece = piece.clone();
                test_piece.rotation = target_rotation;
                test_piece.shape = test_piece.get_rotated_shape(target_rotation);
                test_piece.move_by(dx, dy);

                if self.is_valid_position(&test_piece) {
                    *piece = test_piece;
                    return true;
                }
            }
        }
        false
    }

    // 하드 드롭 (한번에 끝까지 떨어뜨리기)
    pub fn hard_drop(&mut self) -> u32 {
        let mut drop_distance = 0;

        while self.move_down() {
            drop_distance += 1;
        }

        self.lock_piece();
        drop_distance
    }

    // 소프트 드롭 (빠르게 내리기)
    pub fn soft_drop(&mut self) -> bool {
        if self.move_down() {
            self.score += 1; // 소프트 드롭 보너스
            true
        } else {
            false
        }
    }

    // 테트로미노 홀드
    pub fn hold(&mut self) -> bool {
        if !self.can_hold || self.current_piece.is_none() {
            return false;
        }

        let current_type = self.current_piece.as_ref().unwrap().piece_type;

        if let Some(held_type) = self.held_piece {
            // 홀드된 피스가 있으면 교체
            self.current_piece = Some(Tetromino::new(held_type, SPAWN_X, SPAWN_Y));
            self.held_piece = Some(current_type);
        } else {
            // 홀드된 피스가 없으면 현재 피스를 홀드하고 다음 피스 스폰
            self.held_piece = Some(current_type);
            self.spawn_next_piece();
        }

        self.can_hold = false;
        true
    }

    // 테트로미노를 보드에 고정
    pub fn lock_piece(&mut self) -> bool {
        if let Some(piece) = self.current_piece.take() {
            // 블록을 보드에 배치
            for pos in piece.get_occupied_positions() {
                if pos.y >= 0 && pos.y < (BOARD_HEIGHT + BOARD_BUFFER) as i32 &&
                    pos.x >= 0 && pos.x < BOARD_WIDTH as i32 {
                    self.grid[pos.y as usize][pos.x as usize] = Some(piece.piece_type);
                }
            }

            // 라인 클리어 확인
            let cleared_lines = self.clear_lines();
            let previous_combo = self.combo_count;

            if cleared_lines > 0 {
                self.combo_count += 1;
                self.lines_cleared += cleared_lines;
                self.update_score_and_level(cleared_lines, previous_combo);

                // B2B 체크 (테트리스 또는 T-spin)
                let is_tetris = cleared_lines == 4;
                let is_t_spin = self.check_t_spin(&piece, cleared_lines);

                if is_tetris || is_t_spin {
                    if self.back_to_back {
                        // B2B 보너스
                        self.score += 500 * self.level;
                    }
                    self.back_to_back = true;
                } else {
                    self.back_to_back = false;
                }
            } else {
                self.combo_count = 0;
            }

            // 공격 라인 처리
            self.process_garbage_attack();

            // 다음 테트로미노 생성
            self.spawn_next_piece();

            // 게임 오버 체크 (새로운 블록이 배치될 수 없으면)
            if let Some(ref new_piece) = self.current_piece {
                if !self.is_valid_position(new_piece) {
                    return false; // 게임 오버
                }
            }
        }
        true
    }

    // T-spin 감지
    fn check_t_spin(&self, piece: &Tetromino, lines_cleared: u32) -> bool {
        if piece.piece_type != TetrominoType::T || lines_cleared == 0 {
            return false;
        }

        // T 피스의 중심점 계산
        let center_x = piece.position.x + 1;
        let center_y = piece.position.y + 1;

        // 4모서리 체크
        let corners = [
            (center_x - 1, center_y - 1), // 좌상
            (center_x + 1, center_y - 1), // 우상
            (center_x - 1, center_y + 1), // 좌하
            (center_x + 1, center_y + 1), // 우하
        ];

        let mut blocked_corners = 0;
        for (x, y) in corners {
            if x < 0 || x >= BOARD_WIDTH as i32 ||
                y < 0 || y >= (BOARD_HEIGHT + BOARD_BUFFER) as i32 ||
                self.grid[y as usize][x as usize].is_some() {
                blocked_corners += 1;
            }
        }

        blocked_corners >= 3
    }

    // 완성된 라인 제거
    fn clear_lines(&mut self) -> u32 {
        let mut cleared_count = 0;
        let mut y = (BOARD_HEIGHT + BOARD_BUFFER) as i32 - 1;

        while y >= 0 {
            if self.is_line_full(y as usize) {
                self.remove_line(y as usize);
                cleared_count += 1;
            } else {
                y -= 1;
            }
        }

        cleared_count
    }

    // 라인이 꽉 찼는지 확인
    fn is_line_full(&self, y: usize) -> bool {
        if y >= BOARD_HEIGHT + BOARD_BUFFER {
            return false;
        }
        self.grid[y].iter().all(|cell| cell.is_some())
    }

    // 라인 제거 및 위 블록들을 아래로 이동
    fn remove_line(&mut self, y: usize) {
        // 해당 라인 제거
        self.grid.remove(y);
        // 맨 위에 빈 라인 추가
        self.grid.insert(0, vec![None; BOARD_WIDTH]);
    }

    // 점수 및 레벨 업데이트
    fn update_score_and_level(&mut self, cleared_lines: u32, combo_count: u32) {
        // 기본 라인 클리어 점수
        let line_score = match cleared_lines {
            1 => 100,
            2 => 300,
            3 => 500,
            4 => 800, // 테트리스!
            _ => 0,
        };

        // 콤보 보너스
        let combo_bonus = combo_count * 50;

        self.score += (line_score + combo_bonus) * self.level;

        // 레벨업 (10라인마다)
        let new_level = (self.lines_cleared / 10) + 1;
        if new_level > self.level {
            self.level = new_level;
            // 레벨이 올라갈수록 떨어지는 속도 증가
            self.fall_time = std::cmp::max(50, 1000 - (self.level - 1) * 50);
        }
    }

    // 공격 라인 추가 (멀티플레이어용)
    pub fn add_garbage_lines(&mut self, count: u32) {
        for _ in 0..count {
            // 맨 위 라인이 비어있는지 확인
            if self.grid[0].iter().any(|cell| cell.is_some()) {
                return; // 게임 오버
            }

            // 맨 위 라인 제거
            self.grid.remove(0);

            // 맨 아래에 쓰레기 라인 추가 (한 칸은 비워둠)
            let mut garbage_line = vec![Some(TetrominoType::I); BOARD_WIDTH];
            let hole_position = rand::random::<usize>() % BOARD_WIDTH;
            garbage_line[hole_position] = None;

            self.grid.push(garbage_line);
        }
    }

    // 공격 큐 처리
    fn process_garbage_attack(&mut self) {
        while let Some(attack_count) = self.attack_queue.pop_front() {
            self.add_garbage_lines(attack_count);
        }
    }

    // 라인 클리어로 상대방에게 보낼 공격 라인 수 계산
    pub fn calculate_attack_lines(&self, cleared_lines: u32, is_t_spin: bool) -> u32 {
        let mut attack = match cleared_lines {
            1 => if is_t_spin { 2 } else { 0 },
            2 => if is_t_spin { 4 } else { 1 },
            3 => if is_t_spin { 6 } else { 2 },
            4 => 4, // 테트리스
            _ => 0,
        };

        // B2B 보너스
        if self.back_to_back && (cleared_lines == 4 || is_t_spin) {
            attack += 1;
        }

        // 콤보 보너스
        if self.combo_count > 1 {
            attack += (self.combo_count - 1) / 2;
        }

        attack
    }

    // 게임 오버 체크
    pub fn is_game_over(&self) -> bool {
        if let Some(ref piece) = self.current_piece {
            !self.is_valid_position(piece)
        } else {
            false
        }
    }

    // 현재 낙하 중인 블록의 예상 착지 위치 계산 (고스트 피스)
    pub fn get_ghost_piece(&self) -> Option<Tetromino> {
        if let Some(ref piece) = self.current_piece {
            let mut ghost = piece.clone();

            while self.is_valid_position(&ghost) {
                ghost.move_by(0, 1);
            }
            ghost.move_by(0, -1); // 마지막 유효한 위치로 되돌리기

            Some(ghost)
        } else {
            None
        }
    }

    // 자동 낙하 시간 체크
    pub fn should_auto_fall(&self, current_time: u64) -> bool {
        current_time >= self.last_fall_time + self.fall_time
    }

    // 마지막 낙하 시간 업데이트
    pub fn update_fall_time(&mut self, current_time: u64) {
        self.last_fall_time = current_time;
    }

    // 가시 영역만 반환 (상단 버퍼 제외)
    pub fn get_visible_grid(&self) -> Vec<Vec<Option<TetrominoType>>> {
        self.grid[BOARD_BUFFER..].to_vec()
    }

    // 현재 피스의 랜딩 높이 계산 (AI용)
    pub fn get_landing_height(&self) -> i32 {
        if let Some(ghost) = self.get_ghost_piece() {
            ghost.position.y
        } else {
            0
        }
    }

    // 구멍 개수 계산 (AI용)
    pub fn count_holes(&self) -> u32 {
        let mut holes = 0;

        for x in 0..BOARD_WIDTH {
            let mut found_block = false;
            for y in BOARD_BUFFER..(BOARD_HEIGHT + BOARD_BUFFER) {
                if self.grid[y][x].is_some() {
                    found_block = true;
                } else if found_block {
                    holes += 1;
                }
            }
        }

        holes
    }

    // 보드 높이 계산 (AI용)
    pub fn get_height(&self) -> u32 {
        for y in BOARD_BUFFER..(BOARD_HEIGHT + BOARD_BUFFER) {
            if self.grid[y].iter().any(|cell| cell.is_some()) {
                return (BOARD_HEIGHT + BOARD_BUFFER - y) as u32;
            }
        }
        0
    }
}