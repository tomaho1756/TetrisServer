// src/models/tetromino.rs
use serde::{Deserialize, Serialize};
use rand::{thread_rng, Rng};

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq)]
pub enum TetrominoType {
    I, // 직선
    O, // 정사각형
    T, // T자
    S, // S자
    Z, // Z자
    J, // J자
    L, // L자
}

impl TetrominoType {
    pub fn random() -> Self {
        let mut rng = thread_rng();
        match rng.gen_range(0..7) {
            0 => TetrominoType::I,
            1 => TetrominoType::O,
            2 => TetrominoType::T,
            3 => TetrominoType::S,
            4 => TetrominoType::Z,
            5 => TetrominoType::J,
            _ => TetrominoType::L,
        }
    }

    pub fn get_color(&self) -> &'static str {
        match self {
            TetrominoType::I => "#00CED1", // 청록색
            TetrominoType::O => "#FFD700", // 금색
            TetrominoType::T => "#9932CC", // 보라색
            TetrominoType::S => "#32CD32", // 라임색
            TetrominoType::Z => "#DC143C", // 빨간색
            TetrominoType::J => "#1E90FF", // 파란색
            TetrominoType::L => "#FF8C00", // 오렌지색
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Position {
    pub x: i32,
    pub y: i32,
}

impl Position {
    pub fn new(x: i32, y: i32) -> Self {
        Self { x, y }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Tetromino {
    pub piece_type: TetrominoType,
    pub position: Position,
    pub rotation: u8, // 0, 1, 2, 3 (0도, 90도, 180도, 270도)
    pub shape: Vec<Vec<bool>>, // 블록 모양 (4x4 격자)
}

impl Tetromino {
    pub fn new(piece_type: TetrominoType, x: i32, y: i32) -> Self {
        let shape = Self::get_initial_shape(&piece_type);
        Self {
            piece_type,
            position: Position::new(x, y),
            rotation: 0,
            shape,
        }
    }

    // 각 테트로미노의 초기 모양 정의
    fn get_initial_shape(piece_type: &TetrominoType) -> Vec<Vec<bool>> {
        match piece_type {
            TetrominoType::I => vec![
                vec![false, false, false, false],
                vec![true, true, true, true],
                vec![false, false, false, false],
                vec![false, false, false, false],
            ],
            TetrominoType::O => vec![
                vec![false, false, false, false],
                vec![false, true, true, false],
                vec![false, true, true, false],
                vec![false, false, false, false],
            ],
            TetrominoType::T => vec![
                vec![false, false, false, false],
                vec![false, true, false, false],
                vec![true, true, true, false],
                vec![false, false, false, false],
            ],
            TetrominoType::S => vec![
                vec![false, false, false, false],
                vec![false, true, true, false],
                vec![true, true, false, false],
                vec![false, false, false, false],
            ],
            TetrominoType::Z => vec![
                vec![false, false, false, false],
                vec![true, true, false, false],
                vec![false, true, true, false],
                vec![false, false, false, false],
            ],
            TetrominoType::J => vec![
                vec![false, false, false, false],
                vec![true, false, false, false],
                vec![true, true, true, false],
                vec![false, false, false, false],
            ],
            TetrominoType::L => vec![
                vec![false, false, false, false],
                vec![false, false, true, false],
                vec![true, true, true, false],
                vec![false, false, false, false],
            ],
        }
    }

    // 테트로미노 회전
    pub fn rotate(&mut self) {
        self.rotation = (self.rotation + 1) % 4;
        self.shape = self.get_rotated_shape(self.rotation);
    }

    // 회전된 모양 계산
    fn get_rotated_shape(&self, rotation: u8) -> Vec<Vec<bool>> {
        let mut shape = Self::get_initial_shape(&self.piece_type);

        for _ in 0..rotation {
            shape = self.rotate_matrix_90(&shape);
        }

        shape
    }

    // 4x4 매트릭스를 시계방향으로 90도 회전
    fn rotate_matrix_90(&self, matrix: &Vec<Vec<bool>>) -> Vec<Vec<bool>> {
        let mut rotated = vec![vec![false; 4]; 4];

        for i in 0..4 {
            for j in 0..4 {
                rotated[j][3 - i] = matrix[i][j];
            }
        }

        rotated
    }

    // 테트로미노 이동
    pub fn move_by(&mut self, dx: i32, dy: i32) {
        self.position.x += dx;
        self.position.y += dy;
    }

    // 실제 블록이 있는 위치들 반환
    pub fn get_occupied_positions(&self) -> Vec<Position> {
        let mut positions = Vec::new();

        for (row, line) in self.shape.iter().enumerate() {
            for (col, &is_filled) in line.iter().enumerate() {
                if is_filled {
                    positions.push(Position::new(
                        self.position.x + col as i32,
                        self.position.y + row as i32,
                    ));
                }
            }
        }

        positions
    }

    // 바운딩 박스 계산 (충돌 검사 최적화용)
    pub fn get_bounding_box(&self) -> (i32, i32, i32, i32) {
        let mut min_x = 4;
        let mut max_x = -1;
        let mut min_y = 4;
        let mut max_y = -1;

        for (row, line) in self.shape.iter().enumerate() {
            for (col, &is_filled) in line.iter().enumerate() {
                if is_filled {
                    min_x = min_x.min(col as i32);
                    max_x = max_x.max(col as i32);
                    min_y = min_y.min(row as i32);
                    max_y = max_y.max(row as i32);
                }
            }
        }

        (
            self.position.x + min_x,
            self.position.y + min_y,
            self.position.x + max_x,
            self.position.y + max_y,
        )
    }

    // Super Rotation System (SRS) 킥 테이블
    pub fn get_kick_offsets(&self, from_rotation: u8, to_rotation: u8) -> Vec<(i32, i32)> {
        // I 피스는 특별한 킥 테이블 사용
        if self.piece_type == TetrominoType::I {
            self.get_i_piece_kicks(from_rotation, to_rotation)
        } else {
            self.get_standard_kicks(from_rotation, to_rotation)
        }
    }

    // 표준 피스 킥 오프셋
    fn get_standard_kicks(&self, from: u8, to: u8) -> Vec<(i32, i32)> {
        let kicks = [
            // 0->1, 2->3
            vec![(0, 0), (-1, 0), (-1, 1), (0, -2), (-1, -2)],
            // 1->0, 3->2
            vec![(0, 0), (1, 0), (1, -1), (0, 2), (1, 2)],
            // 1->2, 3->0
            vec![(0, 0), (1, 0), (1, -1), (0, 2), (1, 2)],
            // 2->1, 0->3
            vec![(0, 0), (-1, 0), (-1, 1), (0, -2), (-1, -2)],
            // 2->3, 0->1
            vec![(0, 0), (1, 0), (1, 1), (0, -2), (1, -2)],
            // 3->2, 1->0
            vec![(0, 0), (-1, 0), (-1, -1), (0, 2), (-1, 2)],
            // 3->0, 1->2
            vec![(0, 0), (-1, 0), (-1, -1), (0, 2), (-1, 2)],
            // 0->3, 2->1
            vec![(0, 0), (1, 0), (1, 1), (0, -2), (1, -2)],
        ];

        let index = match (from, to) {
            (0, 1) | (2, 3) => 0,
            (1, 0) | (3, 2) => 1,
            (1, 2) | (3, 0) => 2,
            (2, 1) | (0, 3) => 3,
            (2, 3) | (0, 1) => 4,
            (3, 2) | (1, 0) => 5,
            (3, 0) | (1, 2) => 6,
            (0, 3) | (2, 1) => 7,
            _ => 0,
        };

        kicks[index].clone()
    }

    // I 피스 전용 킥 오프셋
    fn get_i_piece_kicks(&self, from: u8, to: u8) -> Vec<(i32, i32)> {
        let kicks = [
            // 0->1, 2->3
            vec![(0, 0), (-2, 0), (1, 0), (-2, -1), (1, 2)],
            // 1->0, 3->2
            vec![(0, 0), (2, 0), (-1, 0), (2, 1), (-1, -2)],
            // 1->2, 3->0
            vec![(0, 0), (-1, 0), (2, 0), (-1, 2), (2, -1)],
            // 2->1, 0->3
            vec![(0, 0), (1, 0), (-2, 0), (1, -2), (-2, 1)],
            // 2->3, 0->1
            vec![(0, 0), (2, 0), (-1, 0), (2, 1), (-1, -2)],
            // 3->2, 1->0
            vec![(0, 0), (-2, 0), (1, 0), (-2, -1), (1, 2)],
            // 3->0, 1->2
            vec![(0, 0), (1, 0), (-2, 0), (1, -2), (-2, 1)],
            // 0->3, 2->1
            vec![(0, 0), (-1, 0), (2, 0), (-1, 2), (2, -1)],
        ];

        let index = match (from, to) {
            (0, 1) | (2, 3) => 0,
            (1, 0) | (3, 2) => 1,
            (1, 2) | (3, 0) => 2,
            (2, 1) | (0, 3) => 3,
            (2, 3) | (0, 1) => 4,
            (3, 2) | (1, 0) => 5,
            (3, 0) | (1, 2) => 6,
            (0, 3) | (2, 1) => 7,
            _ => 0,
        };

        kicks[index].clone()
    }
}