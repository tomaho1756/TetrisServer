// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String? ?? '',
      stats: json['stats'] == null
          ? const UserStats()
          : UserStats.fromJson(json['stats'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      isOnline: json['isOnline'] as bool? ?? false,
      rank: $enumDecodeNullable(_$UserRankEnumMap, json['rank']) ??
          UserRank.bronze,
      experience: (json['experience'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'stats': instance.stats,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'isOnline': instance.isOnline,
      'rank': _$UserRankEnumMap[instance.rank]!,
      'experience': instance.experience,
      'level': instance.level,
    };

const _$UserRankEnumMap = {
  UserRank.bronze: 'bronze',
  UserRank.silver: 'silver',
  UserRank.gold: 'gold',
  UserRank.platinum: 'platinum',
  UserRank.diamond: 'diamond',
  UserRank.master: 'master',
  UserRank.grandmaster: 'grandmaster',
};

_$UserStatsImpl _$$UserStatsImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsImpl(
      totalGames: (json['totalGames'] as num?)?.toInt() ?? 0,
      totalWins: (json['totalWins'] as num?)?.toInt() ?? 0,
      totalLosses: (json['totalLosses'] as num?)?.toInt() ?? 0,
      totalScore: (json['totalScore'] as num?)?.toInt() ?? 0,
      totalLinesCleared: (json['totalLinesCleared'] as num?)?.toInt() ?? 0,
      totalTimePlayed: (json['totalTimePlayed'] as num?)?.toInt() ?? 0,
      maxLevel: (json['maxLevel'] as num?)?.toInt() ?? 0,
      maxScore: (json['maxScore'] as num?)?.toInt() ?? 0,
      totalTetris: (json['totalTetris'] as num?)?.toInt() ?? 0,
      maxCombo: (json['maxCombo'] as num?)?.toInt() ?? 0,
      averageScore: (json['averageScore'] as num?)?.toDouble() ?? 0,
      winRate: (json['winRate'] as num?)?.toDouble() ?? 0.0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      maxStreak: (json['maxStreak'] as num?)?.toInt() ?? 0,
      singlePlayerGames: (json['singlePlayerGames'] as num?)?.toInt() ?? 0,
      multiPlayerGames: (json['multiPlayerGames'] as num?)?.toInt() ?? 0,
      teamGames: (json['teamGames'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'totalGames': instance.totalGames,
      'totalWins': instance.totalWins,
      'totalLosses': instance.totalLosses,
      'totalScore': instance.totalScore,
      'totalLinesCleared': instance.totalLinesCleared,
      'totalTimePlayed': instance.totalTimePlayed,
      'maxLevel': instance.maxLevel,
      'maxScore': instance.maxScore,
      'totalTetris': instance.totalTetris,
      'maxCombo': instance.maxCombo,
      'averageScore': instance.averageScore,
      'winRate': instance.winRate,
      'currentStreak': instance.currentStreak,
      'maxStreak': instance.maxStreak,
      'singlePlayerGames': instance.singlePlayerGames,
      'multiPlayerGames': instance.multiPlayerGames,
      'teamGames': instance.teamGames,
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => Achievement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentGames: (json['recentGames'] as List<dynamic>?)
              ?.map((e) => GameRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      settings: json['settings'] == null
          ? const UserSettings()
          : UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'achievements': instance.achievements,
      'recentGames': instance.recentGames,
      'settings': instance.settings,
    };

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      maxProgress: (json['maxProgress'] as num?)?.toInt() ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
      'progress': instance.progress,
      'maxProgress': instance.maxProgress,
      'isCompleted': instance.isCompleted,
    };

_$GameRecordImpl _$$GameRecordImplFromJson(Map<String, dynamic> json) =>
    _$GameRecordImpl(
      id: json['id'] as String,
      gameMode: json['gameMode'] as String,
      score: (json['score'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      linesCleared: (json['linesCleared'] as num).toInt(),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      playedAt: DateTime.parse(json['playedAt'] as String),
      isWin: json['isWin'] as bool? ?? false,
      opponents: (json['opponents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      roomId: json['roomId'] as String?,
    );

Map<String, dynamic> _$$GameRecordImplToJson(_$GameRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameMode': instance.gameMode,
      'score': instance.score,
      'level': instance.level,
      'linesCleared': instance.linesCleared,
      'duration': instance.duration.inMicroseconds,
      'playedAt': instance.playedAt.toIso8601String(),
      'isWin': instance.isWin,
      'opponents': instance.opponents,
      'roomId': instance.roomId,
    };

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      musicEnabled: json['musicEnabled'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      soundVolume: (json['soundVolume'] as num?)?.toDouble() ?? 0.7,
      musicVolume: (json['musicVolume'] as num?)?.toDouble() ?? 0.5,
      showGhost: json['showGhost'] as bool? ?? true,
      showGrid: json['showGrid'] as bool? ?? true,
      autoRepeat: json['autoRepeat'] as bool? ?? false,
      autoRepeatDelay: (json['autoRepeatDelay'] as num?)?.toInt() ?? 150,
      autoRepeatRate: (json['autoRepeatRate'] as num?)?.toInt() ?? 50,
      softDropSpeed: (json['softDropSpeed'] as num?)?.toInt() ?? 500,
      showNextPieces: json['showNextPieces'] as bool? ?? true,
      nextPiecesCount: (json['nextPiecesCount'] as num?)?.toInt() ?? 5,
      showHoldPiece: json['showHoldPiece'] as bool? ?? true,
      controlScheme:
          $enumDecodeNullable(_$ControlSchemeEnumMap, json['controlScheme']) ??
              ControlScheme.classic,
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      language: json['language'] as String? ?? 'ko',
      notifications: json['notifications'] as bool? ?? true,
      gameInvites: json['gameInvites'] as bool? ?? true,
      friendRequestsOnly: json['friendRequestsOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'soundEnabled': instance.soundEnabled,
      'musicEnabled': instance.musicEnabled,
      'vibrationEnabled': instance.vibrationEnabled,
      'soundVolume': instance.soundVolume,
      'musicVolume': instance.musicVolume,
      'showGhost': instance.showGhost,
      'showGrid': instance.showGrid,
      'autoRepeat': instance.autoRepeat,
      'autoRepeatDelay': instance.autoRepeatDelay,
      'autoRepeatRate': instance.autoRepeatRate,
      'softDropSpeed': instance.softDropSpeed,
      'showNextPieces': instance.showNextPieces,
      'nextPiecesCount': instance.nextPiecesCount,
      'showHoldPiece': instance.showHoldPiece,
      'controlScheme': _$ControlSchemeEnumMap[instance.controlScheme]!,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'language': instance.language,
      'notifications': instance.notifications,
      'gameInvites': instance.gameInvites,
      'friendRequestsOnly': instance.friendRequestsOnly,
    };

const _$ControlSchemeEnumMap = {
  ControlScheme.classic: 'classic',
  ControlScheme.modern: 'modern',
  ControlScheme.custom: 'custom',
};

const _$ThemeModeEnumMap = {
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
  ThemeMode.system: 'system',
};
