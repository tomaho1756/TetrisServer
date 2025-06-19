# 🎮 테트리스 멀티플레이어 서버

Rust로 개발된 실시간 멀티플레이어 테트리스 게임 서버입니다.

## ✨ 주요 기능

### 🔐 사용자 인증 시스템
- JWT 토큰 기반 인증
- bcrypt 비밀번호 해싱
- 이메일/사용자명 중복 확인
- 입력 유효성 검사

### 🎯 게임 시스템
- **싱글플레이어**: 혼자서 즐기는 클래식 테트리스
- **1vs1**: 실시간 대전 모드
- **2vs2**: 팀 기반 대전 모드
- 실시간 게임 상태 동기화
- 테트로미노 로직 (회전, 이동, 라인클리어)
- 홀드 기능 및 고스트 피스
- SRS (Super Rotation System) 지원

### 🏠 방 관리 시스템
- 방 생성/참가/나가기
- 비밀번호 보호 방
- 관전 시스템
- 방장 권한 관리
- 실시간 채팅

### 📊 통계 및 리더보드
- 사용자별 게임 통계
- 글로벌 리더보드
- 레이팅 시스템
- 게임 기록 저장

### 🔄 실시간 통신
- WebSocket 기반 실시간 통신
- 게임 상태 실시간 동기화
- 채팅 시스템
- 사용자 온라인 상태 관리

## 🛠️ 기술 스택

- **언어**: Rust 🦀
- **웹 프레임워크**: Axum
- **데이터베이스**: SQLite (sqlx)
- **실시간 통신**: Socket.IO
- **인증**: JWT + bcrypt
- **비동기 런타임**: Tokio

## 📋 필수 요구사항

- Rust 1.70+
- SQLite 3.0+

## 🚀 설치 및 실행

### 1. 프로젝트 클론
```bash
git clone <repository-url>
cd TetrisServer
```

### 2. 환경 설정
`.env` 파일을 수정하여 필요한 환경 변수를 설정하세요:

```env
DATABASE_URL=sqlite:tetris.db
JWT_SECRET=your-super-secret-key-here
HOST=0.0.0.0
PORT=3000
```

### 3. 의존성 설치 및 빌드
```bash
cargo build --release
```

### 4. 서버 실행
```bash
cargo run --release
```

서버가 성공적으로 시작되면 다음 메시지가 표시됩니다:
```
🎮 테트리스 멀티플레이어 서버가 http://0.0.0.0:3000 에서 실행 중입니다!
🔌 WebSocket 엔드포인트: ws://0.0.0.0:3000/socket.io/
```

## 📡 API 엔드포인트

### 인증
- `POST /api/auth/register` - 사용자 등록
- `POST /api/auth/login` - 사용자 로그인

### 게임
- `POST /api/game/start` - 싱글플레이어 게임 시작
- `POST /api/game/:id/move` - 플레이어 액션 실행
- `GET /api/game/:id` - 게임 상태 조회
- `POST /api/game/:id/leave` - 게임 나가기

### 통계
- `GET /api/users/:id/stats` - 사용자 통계 조회
- `GET /api/leaderboard` - 리더보드 조회
- `POST /api/game/stats` - 게임 통계 저장

### 매칭
- `POST /api/matchmaking/request` - 매칭 요청
- `DELETE /api/matchmaking/cancel` - 매칭 취소

### 방 관리
- `GET /api/rooms` - 방 목록 조회
- `POST /api/rooms` - 방 생성
- `GET /api/rooms/:id` - 방 정보 조회
- `POST /api/rooms/:id/join` - 방 참가
- `POST /api/rooms/:id/leave` - 방 나가기
- `POST /api/rooms/:id/start` - 방에서 게임 시작
- `POST /api/rooms/join-by-code` - 방 코드로 참가

### 채팅
- `GET /api/chat/:room_id/messages` - 채팅 메시지 조회
- `POST /api/chat/:room_id/send` - 채팅 메시지 전송

## 🔌 WebSocket 이벤트

### 클라이언트 → 서버
- `authenticate` - 인증 토큰 전송
- `ping` - 핑 전송

### 서버 → 클라이언트
- `message` - 모든 게임 이벤트
- `authenticated` - 인증 성공
- `authentication_error` - 인증 실패
- `pong` - 핑 응답

### 게임 이벤트 (message 타입)
- `GameState` - 게임 상태 업데이트
- `PlayerJoined` - 플레이어 참가
- `PlayerLeft` - 플레이어 퇴장
- `GameStarted` - 게임 시작
- `GameEnded` - 게임 종료
- `PlayerAction` - 플레이어 액션
- `ChatMessage` - 채팅 메시지
- `RoomCreated` - 방 생성
- `RoomUpdated` - 방 정보 업데이트

## 🎮 게임 규칙

### 기본 조작
- 좌우 이동: `←` `→`
- 회전: `↑`
- 소프트 드롭: `↓`
- 하드 드롭: `Space`
- 홀드: `C`

### 점수 계산
- 단일 라인: 100점 × 레벨
- 더블 라인: 300점 × 레벨
- 트리플 라인: 500점 × 레벨
- 테트리스: 800점 × 레벨
- 소프트 드롭: 1점 per cell
- 하드 드롭: 2점 per cell

### 레벨 시스템
- 10라인 클리어마다 레벨 업
- 레벨이 오를수록 블록이 빨리 떨어짐

### 멀티플레이어 공격
- 라인 클리어 시 상대방에게 쓰레기 라인 전송
- 테트리스, T-spin으로 더 많은 공격 라인 전송
- 콤보와 B2B(Back-to-Back) 보너스

## 🗂️ 프로젝트 구조

```
src/
├── main.rs              # 메인 엔트리포인트
├── models/              # 데이터 모델
│   ├── mod.rs
│   ├── user.rs          # 사용자 모델
│   ├── game_board.rs    # 게임 보드
│   ├── game_sessions.rs # 게임 세션
│   ├── tetromino.rs     # 테트로미노
│   └── room.rs          # 방 모델
├── services/            # 비즈니스 로직
│   ├── mod.rs
│   ├── user_service.rs  # 사용자 서비스
│   ├── game_service.rs  # 게임 서비스
│   ├── room_service.rs  # 방 서비스
│   └── websocket_service.rs # WebSocket 서비스
├── handlers/            # HTTP 핸들러
│   └── mod.rs
└── database/            # 데이터베이스 레이어
    └── mod.rs
```

## 🧪 테스트

```bash
# 단위 테스트 실행
cargo test

# 특정 테스트 실행
cargo test test_name

# 통합 테스트 실행
cargo test --test integration_tests
```

## 📈 성능 최적화

- 비동기 처리로 높은 동시 접속 지원
- 메모리 효율적인 게임 상태 관리
- 빠른 SQLite 쿼리 최적화
- WebSocket 연결 풀링

## 🔧 개발 모드

개발 중에는 다음 명령어로 자동 재시작을 활용할 수 있습니다:

```bash
# cargo-watch 설치
cargo install cargo-watch

# 파일 변경 감지 시 자동 재시작
cargo watch -x run
```

## 🤝 기여하기

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 라이선스

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 감사의 말

- [Tetris Guideline](https://tetris.fandom.com/wiki/Tetris_Guideline) for game rules
- [SRS](https://tetris.fandom.com/wiki/SRS) for rotation system
- Rust 커뮤니티의 훌륭한 crate들

## 📞 지원

문제가 발생하거나 제안사항이 있으시면 이슈를 생성해 주세요.

---

**즐거운 테트리스 게임 되세요! 🎮✨**
