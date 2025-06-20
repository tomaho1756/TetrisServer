import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'user.dart';
import 'game.dart';

part 'multiplayer.freezed.dart';
part 'multiplayer.g.dart';

@freezed
@HiveType(typeId: 6)
class Room with _$Room {
  const factory Room({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String hostId,
    @HiveField(3) required GameMode gameMode,
    @HiveField(4) @Default([]) List<RoomPlayer> players,
    @HiveField(5) @Default(RoomStatus.waiting) RoomStatus status,
    @HiveField(6) required DateTime createdAt,
    @HiveField(7) @Default(4) int maxPlayers,
    @HiveField(8) @Default(false) bool isPrivate,
    @HiveField(9) String? password,
    @HiveField(10) GameSettings? gameSettings,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@freezed
@HiveType(typeId: 7)
class RoomPlayer with _$RoomPlayer {
  const factory RoomPlayer({
    @HiveField(0) required String userId,
    @HiveField(1) required String username,
    @HiveField(2) String? avatarPath,
    @HiveField(3) @Default(PlayerStatus.waiting) PlayerStatus status,
    @HiveField(4) @Default(false) bool isReady,
    @HiveField(5) @Default(0) int teamId, // 0: no team, 1: team1, 2: team2
    @HiveField(6) DateTime? joinedAt,
    @HiveField(7) GameState? gameState,
    @HiveField(8) @Default(0) int score,
    @HiveField(9) @Default(0) int lines,
    @HiveField(10) @Default(1) int level,
    @HiveField(11) @Default(false) bool isAlive,
  }) = _RoomPlayer;

  factory RoomPlayer.fromUser(User user) => RoomPlayer(
    userId: user.id,
    username: user.username,
    avatarPath: user.avatarPath,
    joinedAt: DateTime.now(),
    isAlive: true,
  );

  factory RoomPlayer.fromJson(Map<String, dynamic> json) => _$RoomPlayerFromJson(json);
}

@freezed
class MultiplayerSession with _$MultiplayerSession {
  const factory MultiplayerSession({
    required Room room,
    required String currentUserId,
    @Default({}) Map<String, GameState> playerStates,
    @Default([]) List<MultiplayerAction> actionHistory,
    @Default([]) List<AttackLines> pendingAttacks,
    DateTime? gameStartTime,
    DateTime? gameEndTime,
    String? winnerId,
    @Default({}) Map<String, int> teamScores,
  }) = _MultiplayerSession;

  factory MultiplayerSession.fromJson(Map<String, dynamic> json) => _$MultiplayerSessionFromJson(json);
}

@freezed
class CreateRoomRequest with _$CreateRoomRequest {
  const factory CreateRoomRequest({
    required String name,
    required GameMode gameMode,
    @Default(4) int maxPlayers,
    @Default(false) bool isPrivate,
    String? password,
    GameSettings? gameSettings,
  }) = _CreateRoomRequest;

  factory CreateRoomRequest.fromJson(Map<String, dynamic> json) => _$CreateRoomRequestFromJson(json);
}

@freezed
class JoinRoomRequest with _$JoinRoomRequest {
  const factory JoinRoomRequest({
    required String roomId,
    String? password,
  }) = _JoinRoomRequest;

  factory JoinRoomRequest.fromJson(Map<String, dynamic> json) => _$JoinRoomRequestFromJson(json);
}

@freezed
class GameMessage with _$GameMessage {
  const factory GameMessage.playerJoined({
    required RoomPlayer player,
  }) = PlayerJoinedMessage;

  const factory GameMessage.playerLeft({
    required String playerId,
  }) = PlayerLeftMessage;

  const factory GameMessage.playerReady({
    required String playerId,
    required bool isReady,
  }) = PlayerReadyMessage;

  const factory GameMessage.gameStarted({
    required DateTime startTime,
  }) = GameStartedMessage;

  const factory GameMessage.gameAction({
    required MultiplayerAction action,
  }) = GameActionMessage;

  const factory GameMessage.gameStateUpdate({
    required String playerId,
    required GameState gameState,
  }) = GameStateUpdateMessage;

  const factory GameMessage.attackLines({
    required AttackLines attack,
  }) = AttackLinesMessage;

  const factory GameMessage.playerEliminated({
    required String playerId,
  }) = PlayerEliminatedMessage;

  const factory GameMessage.gameEnded({
    required String winnerId,
    required Map<String, GameResult> results,
  }) = GameEndedMessage;

  const factory GameMessage.roomSettingsChanged({
    required GameSettings settings,
  }) = RoomSettingsChangedMessage;

  const factory GameMessage.chatMessage({
    required String playerId,
    required String message,
    required DateTime timestamp,
  }) = ChatMessage;

  const factory GameMessage.error({
    required String message,
    String? code,
  }) = ErrorMessage;

  factory GameMessage.fromJson(Map<String, dynamic> json) => _$GameMessageFromJson(json);
}

@HiveType(typeId: 14)
enum RoomStatus {
  @HiveField(0) waiting,
  @HiveField(1) starting,
  @HiveField(2) inGame,
  @HiveField(3) finished,
  @HiveField(4) closed,
}

@HiveType(typeId: 15)
enum PlayerStatus {
  @HiveField(0) waiting,
  @HiveField(1) ready,
  @HiveField(2) playing,
  @HiveField(3) finished,
  @HiveField(4) disconnected,
}

// 매치메이킹 관련
@freezed
class MatchmakingRequest with _$MatchmakingRequest {
  const factory MatchmakingRequest({
    required GameMode gameMode,
    required GameDifficulty difficulty,
    @Default([]) List<String> preferredPlayers,
    @Default([]) List<String> blockedPlayers,
  }) = _MatchmakingRequest;

  factory MatchmakingRequest.fromJson(Map<String, dynamic> json) => _$MatchmakingRequestFromJson(json);
}

@freezed
class MatchmakingResult with _$MatchmakingResult {
  const factory MatchmakingResult({
    required Room room,
    required List<RoomPlayer> matchedPlayers,
    required Duration waitTime,
  }) = _MatchmakingResult;

  factory MatchmakingResult.fromJson(Map<String, dynamic> json) => _$MatchmakingResultFromJson(json);
}
