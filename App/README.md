# Tetris Multiplayer Flutter App

온라인 멀티플레이어 테트리스 게임 Flutter 앱입니다.

## 📱 기능

### ✅ 구현 완료
- 🔐 **사용자 인증 시스템**
  - 이메일/비밀번호 로그인
  - 회원가입
  - JWT 토큰 기반 인증
  - 자동 로그인

- 🎮 **게임 기능**
  - 싱글플레이어 모드
  - 멀티플레이어 모드
  - 실시간 게임 동기화
  - SRS 회전 시스템
  - 홀드 기능
  - 고스트 피스

- 🏠 **방 관리 시스템**
  - 방 생성/참가/나가기
  - 방 코드 시스템
  - 비밀번호 보호 방
  - 실시간 채팅

- 📊 **통계 및 리더보드**
  - 개인 통계 추적
  - 전체 리더보드
  - 게임 기록 저장

- ⚙️ **설정 및 커스터마이징**
  - 테마 설정 (라이트/다크)
  - 오디오 설정
  - 게임플레이 설정
  - 컨트롤 설정

- 👤 **프로필 시스템**
  - 사용자 프로필
  - 성취 시스템
  - 게임 기록

## 🏗️ 프로젝트 구조

```
App/
├── lib/
│   ├── main.dart                 # 앱 진입점
│   ├── app/
│   │   └── app.dart             # 앱 라우팅 설정
│   ├── core/                    # 핵심 기능
│   │   ├── constants/           # 상수 정의
│   │   ├── extensions/          # 확장 기능
│   │   ├── models/              # 데이터 모델
│   │   ├── services/            # 비즈니스 로직 서비스
│   │   ├── theme/               # 테마 설정
│   │   └── utils/               # 유틸리티 함수
│   └── features/                # 기능별 모듈
│       ├── auth/                # 인증
│       ├── game/                # 게임
│       ├── home/                # 홈
│       ├── rooms/               # 방 관리
│       ├── settings/            # 설정
│       ├── profile/             # 프로필
│       ├── leaderboard/         # 리더보드
│       └── splash/              # 스플래시
├── assets/                      # 리소스 파일
│   ├── images/                  # 이미지
│   ├── audio/                   # 오디오
│   ├── fonts/                   # 폰트
│   └── rive/                    # 애니메이션
└── pubspec.yaml                 # 의존성 설정
```

## 🛠️ 기술 스택

- **Framework**: Flutter 3.10+
- **상태 관리**: BLoC (flutter_bloc)
- **라우팅**: GoRouter
- **네트워킹**: Dio + HTTP
- **실시간 통신**: Socket.IO
- **로컬 저장소**: Hive + SharedPreferences
- **오디오**: AudioPlayers
- **애니메이션**: Flutter Animate + Rive
- **코드 생성**: Freezed + JSON Annotation

## 📋 사전 요구사항

- Flutter SDK 3.10.0 이상
- Dart SDK 3.0.0 이상
- Android Studio / VS Code
- Android SDK (Android 개발용)
- Xcode (iOS 개발용)

## 🚀 설치 및 실행

### 1. 저장소 클론
```bash
git clone <repository-url>
cd TetrisServer/App
```

### 2. 의존성 설치
```bash
flutter pub get
```

### 3. 코드 생성
```bash
flutter packages pub run build_runner build
```

### 4. 서버 설정
`lib/core/services/api_service.dart`에서 서버 URL을 올바르게 설정하세요:
```dart
static const String baseUrl = 'http://localhost:8080'; // 개발용
// static const String baseUrl = 'https://your-server.com'; // 프로덕션용
```

### 5. 앱 실행
```bash
flutter run
```

## 🔧 개발 환경 설정

### Android
1. Android Studio 설치
2. Android SDK 설정
3. 에뮬레이터 또는 실제 기기 연결

### iOS
1. Xcode 설치 (macOS 필요)
2. iOS 시뮬레이터 또는 실제 기기 연결

### 코드 생성 (개발 중)
모델이나 BLoC을 수정한 후 다음 명령어로 코드를 재생성하세요:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 📦 빌드

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🎮 게임 조작법

### 키보드 (데스크톱)
- **←/→**: 좌우 이동
- **↓**: 소프트 드롭
- **↑**: 시계방향 회전
- **Space**: 하드 드롭
- **C**: 홀드
- **P/ESC**: 일시정지

### 터치 (모바일)
- **좌우 버튼**: 이동
- **아래 버튼**: 소프트 드롭
- **회전 버튼**: 피스 회전
- **드롭 버튼**: 하드 드롭
- **홀드 버튼**: 홀드

## 🔗 서버 연동

이 앱은 Rust로 작성된 테트리스 서버와 연동됩니다. 서버 설정은 `../src/` 디렉터리를 참조하세요.

### 서버 API 엔드포인트
- `POST /api/auth/login` - 로그인
- `POST /api/auth/register` - 회원가입
- `POST /api/game/start` - 게임 시작
- `GET /api/game/:id` - 게임 상태 조회
- `POST /api/game/:id/move` - 게임 액션
- `GET /api/leaderboard` - 리더보드 조회

### WebSocket 이벤트
- `game:update` - 게임 상태 업데이트
- `room:update` - 방 상태 업데이트
- `chat:message` - 채팅 메시지
- `matchmaking:update` - 매치메이킹 상태

## 🧪 테스트

```bash
# 단위 테스트 실행
flutter test

# 위젯 테스트 실행
flutter test test/widget_test/

# 통합 테스트 실행
flutter test test/integration_test/
```

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

## 🤝 기여하기

1. 포크 생성
2. 기능 브랜치 생성 (`git checkout -b feature/amazing-feature`)
3. 변경사항 커밋 (`git commit -m 'Add amazing feature'`)
4. 브랜치에 푸시 (`git push origin feature/amazing-feature`)
5. Pull Request 생성

## 📞 지원

문제가 있거나 질문이 있으시면 이슈를 생성해주세요.

---

**즐거운 테트리스 게임 되세요! 🎮✨**
