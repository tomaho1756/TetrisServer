import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
@HiveType(typeId: 0)
class User with _$User {
  const factory User({
    @HiveField(0) required String id,
    @HiveField(1) required String username,
    @HiveField(2) required String email,
    @HiveField(3) String? avatarPath,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) required DateTime lastLogin,
    @HiveField(6) @Default(0) int totalScore,
    @HiveField(7) @Default(0) int gamesPlayed,
    @HiveField(8) @Default(0) int gamesWon,
    @HiveField(9) @Default(0) int totalLinesCleared,
    @HiveField(10) @Default(1) int level,
    @HiveField(11) @Default(0) int experience,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
@HiveType(typeId: 1)
class UserStats with _$UserStats {
  const factory UserStats({
    @HiveField(0) required String userId,
    @HiveField(1) @Default(0) int singlePlayerHighScore,
    @HiveField(2) @Default(0) int multiplayerHighScore,
    @HiveField(3) @Default(0) int totalPlayTime, // seconds
    @HiveField(4) @Default(0) int longestGame, // seconds
    @HiveField(5) @Default(0) int perfectGames, // no line clears with gaps
    @HiveField(6) @Default(0) int tetrises, // 4-line clears
    @HiveField(7) @Default({}) Map<String, int> achievementProgress,
    @HiveField(8) @Default([]) List<String> unlockedSkins,
    @HiveField(9) @Default('default') String currentSkin,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) => _$UserStatsFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String username,
    required String email,
    required String password,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required User user,
    required String accessToken,
    required String refreshToken,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
