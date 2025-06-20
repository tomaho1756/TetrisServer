// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  UserStats get stats => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  UserRank get rank => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String username,
            String email,
            String avatarUrl,
            UserStats stats,
            DateTime? createdAt,
            DateTime? lastLoginAt,
            bool isOnline,
            UserRank rank,
            int experience,
            int level)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String username,
            String email,
            String avatarUrl,
            UserStats stats,
            DateTime? createdAt,
            DateTime? lastLoginAt,
            bool isOnline,
            UserRank rank,
            int experience,
            int level)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String username,
            String email,
            String avatarUrl,
            UserStats stats,
            DateTime? createdAt,
            DateTime? lastLoginAt,
            bool isOnline,
            UserRank rank,
            int experience,
            int level)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_User value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_User value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_User value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String avatarUrl,
      UserStats stats,
      DateTime? createdAt,
      DateTime? lastLoginAt,
      bool isOnline,
      UserRank rank,
      int experience,
      int level});

  $UserStatsCopyWith<$Res> get stats;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? avatarUrl = null,
    Object? stats = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
    Object? isOnline = null,
    Object? rank = null,
    Object? experience = null,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStats,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as UserRank,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserStatsCopyWith<$Res> get stats {
    return $UserStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String avatarUrl,
      UserStats stats,
      DateTime? createdAt,
      DateTime? lastLoginAt,
      bool isOnline,
      UserRank rank,
      int experience,
      int level});

  @override
  $UserStatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? avatarUrl = null,
    Object? stats = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
    Object? isOnline = null,
    Object? rank = null,
    Object? experience = null,
    Object? level = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStats,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as UserRank,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.username,
      required this.email,
      this.avatarUrl = '',
      this.stats = const UserStats(),
      this.createdAt,
      this.lastLoginAt,
      this.isOnline = false,
      this.rank = UserRank.bronze,
      this.experience = 0,
      this.level = 0});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  @JsonKey()
  final String avatarUrl;
  @override
  @JsonKey()
  final UserStats stats;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastLoginAt;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  @JsonKey()
  final UserRank rank;
  @override
  @JsonKey()
  final int experience;
  @override
  @JsonKey()
  final int level;

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, avatarUrl: $avatarUrl, stats: $stats, createdAt: $createdAt, lastLoginAt: $lastLoginAt, isOnline: $isOnline, rank: $rank, experience: $experience, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, email, avatarUrl,
      stats, createdAt, lastLoginAt, isOnline, rank, experience, level);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String username,
            String email,
            String avatarUrl,
            UserStats stats,
            DateTime? createdAt,
            DateTime? lastLoginAt,
            bool isOnline,
            UserRank rank,
            int experience,
            int level)
        $default,
  ) {
    return $default(id, username, email, avatarUrl, stats, createdAt,
        lastLoginAt, isOnline, rank, experience, level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String username,
            String email,
            String avatarUrl,
            UserStats stats,
            DateTime? createdAt,
            DateTime? lastLoginAt,
            bool isOnline,
            UserRank rank,
            int experience,
            int level)?
        $default,
  ) {
    return $default?.call(id, username, email, avatarUrl, stats, createdAt,
        lastLoginAt, isOnline, rank, experience, level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String username,
            String email,
            String avatarUrl,
            UserStats stats,
            DateTime? createdAt,
            DateTime? lastLoginAt,
            bool isOnline,
            UserRank rank,
            int experience,
            int level)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, username, email, avatarUrl, stats, createdAt,
          lastLoginAt, isOnline, rank, experience, level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_User value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_User value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_User value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String username,
      required final String email,
      final String avatarUrl,
      final UserStats stats,
      final DateTime? createdAt,
      final DateTime? lastLoginAt,
      final bool isOnline,
      final UserRank rank,
      final int experience,
      final int level}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get avatarUrl;
  @override
  UserStats get stats;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastLoginAt;
  @override
  bool get isOnline;
  @override
  UserRank get rank;
  @override
  int get experience;
  @override
  int get level;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return _UserStats.fromJson(json);
}

/// @nodoc
mixin _$UserStats {
  int get totalGames => throw _privateConstructorUsedError;
  int get totalWins => throw _privateConstructorUsedError;
  int get totalLosses => throw _privateConstructorUsedError;
  int get totalScore => throw _privateConstructorUsedError;
  int get totalLinesCleared => throw _privateConstructorUsedError;
  int get totalTimePlayed => throw _privateConstructorUsedError; // 초 단위
  int get maxLevel => throw _privateConstructorUsedError;
  int get maxScore => throw _privateConstructorUsedError;
  int get totalTetris => throw _privateConstructorUsedError;
  int get maxCombo => throw _privateConstructorUsedError;
  double get averageScore => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get maxStreak => throw _privateConstructorUsedError;
  int get singlePlayerGames => throw _privateConstructorUsedError;
  int get multiPlayerGames => throw _privateConstructorUsedError;
  int get teamGames => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int totalGames,
            int totalWins,
            int totalLosses,
            int totalScore,
            int totalLinesCleared,
            int totalTimePlayed,
            int maxLevel,
            int maxScore,
            int totalTetris,
            int maxCombo,
            double averageScore,
            double winRate,
            int currentStreak,
            int maxStreak,
            int singlePlayerGames,
            int multiPlayerGames,
            int teamGames)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int totalGames,
            int totalWins,
            int totalLosses,
            int totalScore,
            int totalLinesCleared,
            int totalTimePlayed,
            int maxLevel,
            int maxScore,
            int totalTetris,
            int maxCombo,
            double averageScore,
            double winRate,
            int currentStreak,
            int maxStreak,
            int singlePlayerGames,
            int multiPlayerGames,
            int teamGames)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int totalGames,
            int totalWins,
            int totalLosses,
            int totalScore,
            int totalLinesCleared,
            int totalTimePlayed,
            int maxLevel,
            int maxScore,
            int totalTetris,
            int maxCombo,
            double averageScore,
            double winRate,
            int currentStreak,
            int maxStreak,
            int singlePlayerGames,
            int multiPlayerGames,
            int teamGames)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserStats value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserStats value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserStats value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this UserStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call(
      {int totalGames,
      int totalWins,
      int totalLosses,
      int totalScore,
      int totalLinesCleared,
      int totalTimePlayed,
      int maxLevel,
      int maxScore,
      int totalTetris,
      int maxCombo,
      double averageScore,
      double winRate,
      int currentStreak,
      int maxStreak,
      int singlePlayerGames,
      int multiPlayerGames,
      int teamGames});
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGames = null,
    Object? totalWins = null,
    Object? totalLosses = null,
    Object? totalScore = null,
    Object? totalLinesCleared = null,
    Object? totalTimePlayed = null,
    Object? maxLevel = null,
    Object? maxScore = null,
    Object? totalTetris = null,
    Object? maxCombo = null,
    Object? averageScore = null,
    Object? winRate = null,
    Object? currentStreak = null,
    Object? maxStreak = null,
    Object? singlePlayerGames = null,
    Object? multiPlayerGames = null,
    Object? teamGames = null,
  }) {
    return _then(_value.copyWith(
      totalGames: null == totalGames
          ? _value.totalGames
          : totalGames // ignore: cast_nullable_to_non_nullable
              as int,
      totalWins: null == totalWins
          ? _value.totalWins
          : totalWins // ignore: cast_nullable_to_non_nullable
              as int,
      totalLosses: null == totalLosses
          ? _value.totalLosses
          : totalLosses // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalLinesCleared: null == totalLinesCleared
          ? _value.totalLinesCleared
          : totalLinesCleared // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimePlayed: null == totalTimePlayed
          ? _value.totalTimePlayed
          : totalTimePlayed // ignore: cast_nullable_to_non_nullable
              as int,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      maxScore: null == maxScore
          ? _value.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalTetris: null == totalTetris
          ? _value.totalTetris
          : totalTetris // ignore: cast_nullable_to_non_nullable
              as int,
      maxCombo: null == maxCombo
          ? _value.maxCombo
          : maxCombo // ignore: cast_nullable_to_non_nullable
              as int,
      averageScore: null == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double,
      winRate: null == winRate
          ? _value.winRate
          : winRate // ignore: cast_nullable_to_non_nullable
              as double,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      maxStreak: null == maxStreak
          ? _value.maxStreak
          : maxStreak // ignore: cast_nullable_to_non_nullable
              as int,
      singlePlayerGames: null == singlePlayerGames
          ? _value.singlePlayerGames
          : singlePlayerGames // ignore: cast_nullable_to_non_nullable
              as int,
      multiPlayerGames: null == multiPlayerGames
          ? _value.multiPlayerGames
          : multiPlayerGames // ignore: cast_nullable_to_non_nullable
              as int,
      teamGames: null == teamGames
          ? _value.teamGames
          : teamGames // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
          _$UserStatsImpl value, $Res Function(_$UserStatsImpl) then) =
      __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalGames,
      int totalWins,
      int totalLosses,
      int totalScore,
      int totalLinesCleared,
      int totalTimePlayed,
      int maxLevel,
      int maxScore,
      int totalTetris,
      int maxCombo,
      double averageScore,
      double winRate,
      int currentStreak,
      int maxStreak,
      int singlePlayerGames,
      int multiPlayerGames,
      int teamGames});
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
      _$UserStatsImpl _value, $Res Function(_$UserStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGames = null,
    Object? totalWins = null,
    Object? totalLosses = null,
    Object? totalScore = null,
    Object? totalLinesCleared = null,
    Object? totalTimePlayed = null,
    Object? maxLevel = null,
    Object? maxScore = null,
    Object? totalTetris = null,
    Object? maxCombo = null,
    Object? averageScore = null,
    Object? winRate = null,
    Object? currentStreak = null,
    Object? maxStreak = null,
    Object? singlePlayerGames = null,
    Object? multiPlayerGames = null,
    Object? teamGames = null,
  }) {
    return _then(_$UserStatsImpl(
      totalGames: null == totalGames
          ? _value.totalGames
          : totalGames // ignore: cast_nullable_to_non_nullable
              as int,
      totalWins: null == totalWins
          ? _value.totalWins
          : totalWins // ignore: cast_nullable_to_non_nullable
              as int,
      totalLosses: null == totalLosses
          ? _value.totalLosses
          : totalLosses // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalLinesCleared: null == totalLinesCleared
          ? _value.totalLinesCleared
          : totalLinesCleared // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimePlayed: null == totalTimePlayed
          ? _value.totalTimePlayed
          : totalTimePlayed // ignore: cast_nullable_to_non_nullable
              as int,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      maxScore: null == maxScore
          ? _value.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalTetris: null == totalTetris
          ? _value.totalTetris
          : totalTetris // ignore: cast_nullable_to_non_nullable
              as int,
      maxCombo: null == maxCombo
          ? _value.maxCombo
          : maxCombo // ignore: cast_nullable_to_non_nullable
              as int,
      averageScore: null == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double,
      winRate: null == winRate
          ? _value.winRate
          : winRate // ignore: cast_nullable_to_non_nullable
              as double,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      maxStreak: null == maxStreak
          ? _value.maxStreak
          : maxStreak // ignore: cast_nullable_to_non_nullable
              as int,
      singlePlayerGames: null == singlePlayerGames
          ? _value.singlePlayerGames
          : singlePlayerGames // ignore: cast_nullable_to_non_nullable
              as int,
      multiPlayerGames: null == multiPlayerGames
          ? _value.multiPlayerGames
          : multiPlayerGames // ignore: cast_nullable_to_non_nullable
              as int,
      teamGames: null == teamGames
          ? _value.teamGames
          : teamGames // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatsImpl implements _UserStats {
  const _$UserStatsImpl(
      {this.totalGames = 0,
      this.totalWins = 0,
      this.totalLosses = 0,
      this.totalScore = 0,
      this.totalLinesCleared = 0,
      this.totalTimePlayed = 0,
      this.maxLevel = 0,
      this.maxScore = 0,
      this.totalTetris = 0,
      this.maxCombo = 0,
      this.averageScore = 0,
      this.winRate = 0.0,
      this.currentStreak = 0,
      this.maxStreak = 0,
      this.singlePlayerGames = 0,
      this.multiPlayerGames = 0,
      this.teamGames = 0});

  factory _$UserStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatsImplFromJson(json);

  @override
  @JsonKey()
  final int totalGames;
  @override
  @JsonKey()
  final int totalWins;
  @override
  @JsonKey()
  final int totalLosses;
  @override
  @JsonKey()
  final int totalScore;
  @override
  @JsonKey()
  final int totalLinesCleared;
  @override
  @JsonKey()
  final int totalTimePlayed;
// 초 단위
  @override
  @JsonKey()
  final int maxLevel;
  @override
  @JsonKey()
  final int maxScore;
  @override
  @JsonKey()
  final int totalTetris;
  @override
  @JsonKey()
  final int maxCombo;
  @override
  @JsonKey()
  final double averageScore;
  @override
  @JsonKey()
  final double winRate;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int maxStreak;
  @override
  @JsonKey()
  final int singlePlayerGames;
  @override
  @JsonKey()
  final int multiPlayerGames;
  @override
  @JsonKey()
  final int teamGames;

  @override
  String toString() {
    return 'UserStats(totalGames: $totalGames, totalWins: $totalWins, totalLosses: $totalLosses, totalScore: $totalScore, totalLinesCleared: $totalLinesCleared, totalTimePlayed: $totalTimePlayed, maxLevel: $maxLevel, maxScore: $maxScore, totalTetris: $totalTetris, maxCombo: $maxCombo, averageScore: $averageScore, winRate: $winRate, currentStreak: $currentStreak, maxStreak: $maxStreak, singlePlayerGames: $singlePlayerGames, multiPlayerGames: $multiPlayerGames, teamGames: $teamGames)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.totalGames, totalGames) ||
                other.totalGames == totalGames) &&
            (identical(other.totalWins, totalWins) ||
                other.totalWins == totalWins) &&
            (identical(other.totalLosses, totalLosses) ||
                other.totalLosses == totalLosses) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.totalLinesCleared, totalLinesCleared) ||
                other.totalLinesCleared == totalLinesCleared) &&
            (identical(other.totalTimePlayed, totalTimePlayed) ||
                other.totalTimePlayed == totalTimePlayed) &&
            (identical(other.maxLevel, maxLevel) ||
                other.maxLevel == maxLevel) &&
            (identical(other.maxScore, maxScore) ||
                other.maxScore == maxScore) &&
            (identical(other.totalTetris, totalTetris) ||
                other.totalTetris == totalTetris) &&
            (identical(other.maxCombo, maxCombo) ||
                other.maxCombo == maxCombo) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.winRate, winRate) || other.winRate == winRate) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.maxStreak, maxStreak) ||
                other.maxStreak == maxStreak) &&
            (identical(other.singlePlayerGames, singlePlayerGames) ||
                other.singlePlayerGames == singlePlayerGames) &&
            (identical(other.multiPlayerGames, multiPlayerGames) ||
                other.multiPlayerGames == multiPlayerGames) &&
            (identical(other.teamGames, teamGames) ||
                other.teamGames == teamGames));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalGames,
      totalWins,
      totalLosses,
      totalScore,
      totalLinesCleared,
      totalTimePlayed,
      maxLevel,
      maxScore,
      totalTetris,
      maxCombo,
      averageScore,
      winRate,
      currentStreak,
      maxStreak,
      singlePlayerGames,
      multiPlayerGames,
      teamGames);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int totalGames,
            int totalWins,
            int totalLosses,
            int totalScore,
            int totalLinesCleared,
            int totalTimePlayed,
            int maxLevel,
            int maxScore,
            int totalTetris,
            int maxCombo,
            double averageScore,
            double winRate,
            int currentStreak,
            int maxStreak,
            int singlePlayerGames,
            int multiPlayerGames,
            int teamGames)
        $default,
  ) {
    return $default(
        totalGames,
        totalWins,
        totalLosses,
        totalScore,
        totalLinesCleared,
        totalTimePlayed,
        maxLevel,
        maxScore,
        totalTetris,
        maxCombo,
        averageScore,
        winRate,
        currentStreak,
        maxStreak,
        singlePlayerGames,
        multiPlayerGames,
        teamGames);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int totalGames,
            int totalWins,
            int totalLosses,
            int totalScore,
            int totalLinesCleared,
            int totalTimePlayed,
            int maxLevel,
            int maxScore,
            int totalTetris,
            int maxCombo,
            double averageScore,
            double winRate,
            int currentStreak,
            int maxStreak,
            int singlePlayerGames,
            int multiPlayerGames,
            int teamGames)?
        $default,
  ) {
    return $default?.call(
        totalGames,
        totalWins,
        totalLosses,
        totalScore,
        totalLinesCleared,
        totalTimePlayed,
        maxLevel,
        maxScore,
        totalTetris,
        maxCombo,
        averageScore,
        winRate,
        currentStreak,
        maxStreak,
        singlePlayerGames,
        multiPlayerGames,
        teamGames);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int totalGames,
            int totalWins,
            int totalLosses,
            int totalScore,
            int totalLinesCleared,
            int totalTimePlayed,
            int maxLevel,
            int maxScore,
            int totalTetris,
            int maxCombo,
            double averageScore,
            double winRate,
            int currentStreak,
            int maxStreak,
            int singlePlayerGames,
            int multiPlayerGames,
            int teamGames)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          totalGames,
          totalWins,
          totalLosses,
          totalScore,
          totalLinesCleared,
          totalTimePlayed,
          maxLevel,
          maxScore,
          totalTetris,
          maxCombo,
          averageScore,
          winRate,
          currentStreak,
          maxStreak,
          singlePlayerGames,
          multiPlayerGames,
          teamGames);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserStats value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserStats value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserStats value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatsImplToJson(
      this,
    );
  }
}

abstract class _UserStats implements UserStats {
  const factory _UserStats(
      {final int totalGames,
      final int totalWins,
      final int totalLosses,
      final int totalScore,
      final int totalLinesCleared,
      final int totalTimePlayed,
      final int maxLevel,
      final int maxScore,
      final int totalTetris,
      final int maxCombo,
      final double averageScore,
      final double winRate,
      final int currentStreak,
      final int maxStreak,
      final int singlePlayerGames,
      final int multiPlayerGames,
      final int teamGames}) = _$UserStatsImpl;

  factory _UserStats.fromJson(Map<String, dynamic> json) =
      _$UserStatsImpl.fromJson;

  @override
  int get totalGames;
  @override
  int get totalWins;
  @override
  int get totalLosses;
  @override
  int get totalScore;
  @override
  int get totalLinesCleared;
  @override
  int get totalTimePlayed; // 초 단위
  @override
  int get maxLevel;
  @override
  int get maxScore;
  @override
  int get totalTetris;
  @override
  int get maxCombo;
  @override
  double get averageScore;
  @override
  double get winRate;
  @override
  int get currentStreak;
  @override
  int get maxStreak;
  @override
  int get singlePlayerGames;
  @override
  int get multiPlayerGames;
  @override
  int get teamGames;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  User get user => throw _privateConstructorUsedError;
  List<Achievement> get achievements => throw _privateConstructorUsedError;
  List<GameRecord> get recentGames => throw _privateConstructorUsedError;
  UserSettings get settings => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(User user, List<Achievement> achievements,
            List<GameRecord> recentGames, UserSettings settings)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(User user, List<Achievement> achievements,
            List<GameRecord> recentGames, UserSettings settings)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(User user, List<Achievement> achievements,
            List<GameRecord> recentGames, UserSettings settings)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserProfile value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserProfile value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserProfile value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {User user,
      List<Achievement> achievements,
      List<GameRecord> recentGames,
      UserSettings settings});

  $UserCopyWith<$Res> get user;
  $UserSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? achievements = null,
    Object? recentGames = null,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<Achievement>,
      recentGames: null == recentGames
          ? _value.recentGames
          : recentGames // ignore: cast_nullable_to_non_nullable
              as List<GameRecord>,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as UserSettings,
    ) as $Val);
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<$Res> get settings {
    return $UserSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User user,
      List<Achievement> achievements,
      List<GameRecord> recentGames,
      UserSettings settings});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $UserSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? achievements = null,
    Object? recentGames = null,
    Object? settings = null,
  }) {
    return _then(_$UserProfileImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<Achievement>,
      recentGames: null == recentGames
          ? _value._recentGames
          : recentGames // ignore: cast_nullable_to_non_nullable
              as List<GameRecord>,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as UserSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {required this.user,
      final List<Achievement> achievements = const [],
      final List<GameRecord> recentGames = const [],
      this.settings = const UserSettings()})
      : _achievements = achievements,
        _recentGames = recentGames;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final User user;
  final List<Achievement> _achievements;
  @override
  @JsonKey()
  List<Achievement> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  final List<GameRecord> _recentGames;
  @override
  @JsonKey()
  List<GameRecord> get recentGames {
    if (_recentGames is EqualUnmodifiableListView) return _recentGames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentGames);
  }

  @override
  @JsonKey()
  final UserSettings settings;

  @override
  String toString() {
    return 'UserProfile(user: $user, achievements: $achievements, recentGames: $recentGames, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            const DeepCollectionEquality()
                .equals(other._recentGames, _recentGames) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      user,
      const DeepCollectionEquality().hash(_achievements),
      const DeepCollectionEquality().hash(_recentGames),
      settings);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(User user, List<Achievement> achievements,
            List<GameRecord> recentGames, UserSettings settings)
        $default,
  ) {
    return $default(user, achievements, recentGames, settings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(User user, List<Achievement> achievements,
            List<GameRecord> recentGames, UserSettings settings)?
        $default,
  ) {
    return $default?.call(user, achievements, recentGames, settings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(User user, List<Achievement> achievements,
            List<GameRecord> recentGames, UserSettings settings)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(user, achievements, recentGames, settings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserProfile value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserProfile value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserProfile value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {required final User user,
      final List<Achievement> achievements,
      final List<GameRecord> recentGames,
      final UserSettings settings}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  User get user;
  @override
  List<Achievement> get achievements;
  @override
  List<GameRecord> get recentGames;
  @override
  UserSettings get settings;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return _Achievement.fromJson(json);
}

/// @nodoc
mixin _$Achievement {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get iconUrl => throw _privateConstructorUsedError;
  DateTime get unlockedAt => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  int get maxProgress => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            String iconUrl,
            DateTime unlockedAt,
            int progress,
            int maxProgress,
            bool isCompleted)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String description,
            String iconUrl,
            DateTime unlockedAt,
            int progress,
            int maxProgress,
            bool isCompleted)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            String iconUrl,
            DateTime unlockedAt,
            int progress,
            int maxProgress,
            bool isCompleted)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Achievement value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Achievement value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Achievement value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Achievement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
          Achievement value, $Res Function(Achievement) then) =
      _$AchievementCopyWithImpl<$Res, Achievement>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String iconUrl,
      DateTime unlockedAt,
      int progress,
      int maxProgress,
      bool isCompleted});
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res, $Val extends Achievement>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? iconUrl = null,
    Object? unlockedAt = null,
    Object? progress = null,
    Object? maxProgress = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      unlockedAt: null == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      maxProgress: null == maxProgress
          ? _value.maxProgress
          : maxProgress // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AchievementImplCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$$AchievementImplCopyWith(
          _$AchievementImpl value, $Res Function(_$AchievementImpl) then) =
      __$$AchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String iconUrl,
      DateTime unlockedAt,
      int progress,
      int maxProgress,
      bool isCompleted});
}

/// @nodoc
class __$$AchievementImplCopyWithImpl<$Res>
    extends _$AchievementCopyWithImpl<$Res, _$AchievementImpl>
    implements _$$AchievementImplCopyWith<$Res> {
  __$$AchievementImplCopyWithImpl(
      _$AchievementImpl _value, $Res Function(_$AchievementImpl) _then)
      : super(_value, _then);

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? iconUrl = null,
    Object? unlockedAt = null,
    Object? progress = null,
    Object? maxProgress = null,
    Object? isCompleted = null,
  }) {
    return _then(_$AchievementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      unlockedAt: null == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      maxProgress: null == maxProgress
          ? _value.maxProgress
          : maxProgress // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementImpl implements _Achievement {
  const _$AchievementImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.iconUrl,
      required this.unlockedAt,
      this.progress = 0,
      this.maxProgress = 0,
      this.isCompleted = false});

  factory _$AchievementImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String iconUrl;
  @override
  final DateTime unlockedAt;
  @override
  @JsonKey()
  final int progress;
  @override
  @JsonKey()
  final int maxProgress;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'Achievement(id: $id, name: $name, description: $description, iconUrl: $iconUrl, unlockedAt: $unlockedAt, progress: $progress, maxProgress: $maxProgress, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.maxProgress, maxProgress) ||
                other.maxProgress == maxProgress) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, iconUrl,
      unlockedAt, progress, maxProgress, isCompleted);

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      __$$AchievementImplCopyWithImpl<_$AchievementImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            String iconUrl,
            DateTime unlockedAt,
            int progress,
            int maxProgress,
            bool isCompleted)
        $default,
  ) {
    return $default(id, name, description, iconUrl, unlockedAt, progress,
        maxProgress, isCompleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String description,
            String iconUrl,
            DateTime unlockedAt,
            int progress,
            int maxProgress,
            bool isCompleted)?
        $default,
  ) {
    return $default?.call(id, name, description, iconUrl, unlockedAt, progress,
        maxProgress, isCompleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            String iconUrl,
            DateTime unlockedAt,
            int progress,
            int maxProgress,
            bool isCompleted)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, name, description, iconUrl, unlockedAt, progress,
          maxProgress, isCompleted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Achievement value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Achievement value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Achievement value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementImplToJson(
      this,
    );
  }
}

abstract class _Achievement implements Achievement {
  const factory _Achievement(
      {required final String id,
      required final String name,
      required final String description,
      required final String iconUrl,
      required final DateTime unlockedAt,
      final int progress,
      final int maxProgress,
      final bool isCompleted}) = _$AchievementImpl;

  factory _Achievement.fromJson(Map<String, dynamic> json) =
      _$AchievementImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get iconUrl;
  @override
  DateTime get unlockedAt;
  @override
  int get progress;
  @override
  int get maxProgress;
  @override
  bool get isCompleted;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameRecord _$GameRecordFromJson(Map<String, dynamic> json) {
  return _GameRecord.fromJson(json);
}

/// @nodoc
mixin _$GameRecord {
  String get id => throw _privateConstructorUsedError;
  String get gameMode => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get linesCleared => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  DateTime get playedAt => throw _privateConstructorUsedError;
  bool get isWin => throw _privateConstructorUsedError;
  List<String> get opponents => throw _privateConstructorUsedError;
  String? get roomId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String gameMode,
            int score,
            int level,
            int linesCleared,
            Duration duration,
            DateTime playedAt,
            bool isWin,
            List<String> opponents,
            String? roomId)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String gameMode,
            int score,
            int level,
            int linesCleared,
            Duration duration,
            DateTime playedAt,
            bool isWin,
            List<String> opponents,
            String? roomId)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String gameMode,
            int score,
            int level,
            int linesCleared,
            Duration duration,
            DateTime playedAt,
            bool isWin,
            List<String> opponents,
            String? roomId)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameRecord value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameRecord value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameRecord value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this GameRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameRecordCopyWith<GameRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRecordCopyWith<$Res> {
  factory $GameRecordCopyWith(
          GameRecord value, $Res Function(GameRecord) then) =
      _$GameRecordCopyWithImpl<$Res, GameRecord>;
  @useResult
  $Res call(
      {String id,
      String gameMode,
      int score,
      int level,
      int linesCleared,
      Duration duration,
      DateTime playedAt,
      bool isWin,
      List<String> opponents,
      String? roomId});
}

/// @nodoc
class _$GameRecordCopyWithImpl<$Res, $Val extends GameRecord>
    implements $GameRecordCopyWith<$Res> {
  _$GameRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gameMode = null,
    Object? score = null,
    Object? level = null,
    Object? linesCleared = null,
    Object? duration = null,
    Object? playedAt = null,
    Object? isWin = null,
    Object? opponents = null,
    Object? roomId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameMode: null == gameMode
          ? _value.gameMode
          : gameMode // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      linesCleared: null == linesCleared
          ? _value.linesCleared
          : linesCleared // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      playedAt: null == playedAt
          ? _value.playedAt
          : playedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isWin: null == isWin
          ? _value.isWin
          : isWin // ignore: cast_nullable_to_non_nullable
              as bool,
      opponents: null == opponents
          ? _value.opponents
          : opponents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameRecordImplCopyWith<$Res>
    implements $GameRecordCopyWith<$Res> {
  factory _$$GameRecordImplCopyWith(
          _$GameRecordImpl value, $Res Function(_$GameRecordImpl) then) =
      __$$GameRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String gameMode,
      int score,
      int level,
      int linesCleared,
      Duration duration,
      DateTime playedAt,
      bool isWin,
      List<String> opponents,
      String? roomId});
}

/// @nodoc
class __$$GameRecordImplCopyWithImpl<$Res>
    extends _$GameRecordCopyWithImpl<$Res, _$GameRecordImpl>
    implements _$$GameRecordImplCopyWith<$Res> {
  __$$GameRecordImplCopyWithImpl(
      _$GameRecordImpl _value, $Res Function(_$GameRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gameMode = null,
    Object? score = null,
    Object? level = null,
    Object? linesCleared = null,
    Object? duration = null,
    Object? playedAt = null,
    Object? isWin = null,
    Object? opponents = null,
    Object? roomId = freezed,
  }) {
    return _then(_$GameRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameMode: null == gameMode
          ? _value.gameMode
          : gameMode // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      linesCleared: null == linesCleared
          ? _value.linesCleared
          : linesCleared // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      playedAt: null == playedAt
          ? _value.playedAt
          : playedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isWin: null == isWin
          ? _value.isWin
          : isWin // ignore: cast_nullable_to_non_nullable
              as bool,
      opponents: null == opponents
          ? _value._opponents
          : opponents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameRecordImpl implements _GameRecord {
  const _$GameRecordImpl(
      {required this.id,
      required this.gameMode,
      required this.score,
      required this.level,
      required this.linesCleared,
      required this.duration,
      required this.playedAt,
      this.isWin = false,
      final List<String> opponents = const [],
      this.roomId})
      : _opponents = opponents;

  factory _$GameRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String gameMode;
  @override
  final int score;
  @override
  final int level;
  @override
  final int linesCleared;
  @override
  final Duration duration;
  @override
  final DateTime playedAt;
  @override
  @JsonKey()
  final bool isWin;
  final List<String> _opponents;
  @override
  @JsonKey()
  List<String> get opponents {
    if (_opponents is EqualUnmodifiableListView) return _opponents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opponents);
  }

  @override
  final String? roomId;

  @override
  String toString() {
    return 'GameRecord(id: $id, gameMode: $gameMode, score: $score, level: $level, linesCleared: $linesCleared, duration: $duration, playedAt: $playedAt, isWin: $isWin, opponents: $opponents, roomId: $roomId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameMode, gameMode) ||
                other.gameMode == gameMode) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.linesCleared, linesCleared) ||
                other.linesCleared == linesCleared) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.playedAt, playedAt) ||
                other.playedAt == playedAt) &&
            (identical(other.isWin, isWin) || other.isWin == isWin) &&
            const DeepCollectionEquality()
                .equals(other._opponents, _opponents) &&
            (identical(other.roomId, roomId) || other.roomId == roomId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      gameMode,
      score,
      level,
      linesCleared,
      duration,
      playedAt,
      isWin,
      const DeepCollectionEquality().hash(_opponents),
      roomId);

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameRecordImplCopyWith<_$GameRecordImpl> get copyWith =>
      __$$GameRecordImplCopyWithImpl<_$GameRecordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String gameMode,
            int score,
            int level,
            int linesCleared,
            Duration duration,
            DateTime playedAt,
            bool isWin,
            List<String> opponents,
            String? roomId)
        $default,
  ) {
    return $default(id, gameMode, score, level, linesCleared, duration,
        playedAt, isWin, opponents, roomId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String gameMode,
            int score,
            int level,
            int linesCleared,
            Duration duration,
            DateTime playedAt,
            bool isWin,
            List<String> opponents,
            String? roomId)?
        $default,
  ) {
    return $default?.call(id, gameMode, score, level, linesCleared, duration,
        playedAt, isWin, opponents, roomId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String gameMode,
            int score,
            int level,
            int linesCleared,
            Duration duration,
            DateTime playedAt,
            bool isWin,
            List<String> opponents,
            String? roomId)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, gameMode, score, level, linesCleared, duration,
          playedAt, isWin, opponents, roomId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameRecord value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameRecord value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameRecord value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GameRecordImplToJson(
      this,
    );
  }
}

abstract class _GameRecord implements GameRecord {
  const factory _GameRecord(
      {required final String id,
      required final String gameMode,
      required final int score,
      required final int level,
      required final int linesCleared,
      required final Duration duration,
      required final DateTime playedAt,
      final bool isWin,
      final List<String> opponents,
      final String? roomId}) = _$GameRecordImpl;

  factory _GameRecord.fromJson(Map<String, dynamic> json) =
      _$GameRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get gameMode;
  @override
  int get score;
  @override
  int get level;
  @override
  int get linesCleared;
  @override
  Duration get duration;
  @override
  DateTime get playedAt;
  @override
  bool get isWin;
  @override
  List<String> get opponents;
  @override
  String? get roomId;

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameRecordImplCopyWith<_$GameRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  bool get soundEnabled => throw _privateConstructorUsedError;
  bool get musicEnabled => throw _privateConstructorUsedError;
  bool get vibrationEnabled => throw _privateConstructorUsedError;
  double get soundVolume => throw _privateConstructorUsedError;
  double get musicVolume => throw _privateConstructorUsedError;
  bool get showGhost => throw _privateConstructorUsedError;
  bool get showGrid => throw _privateConstructorUsedError;
  bool get autoRepeat => throw _privateConstructorUsedError;
  int get autoRepeatDelay => throw _privateConstructorUsedError; // 밀리초
  int get autoRepeatRate => throw _privateConstructorUsedError; // 밀리초
  int get softDropSpeed => throw _privateConstructorUsedError; // 밀리초
  bool get showNextPieces => throw _privateConstructorUsedError;
  int get nextPiecesCount => throw _privateConstructorUsedError;
  bool get showHoldPiece => throw _privateConstructorUsedError;
  ControlScheme get controlScheme => throw _privateConstructorUsedError;
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  bool get notifications => throw _privateConstructorUsedError;
  bool get gameInvites => throw _privateConstructorUsedError;
  bool get friendRequestsOnly => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool soundEnabled,
            bool musicEnabled,
            bool vibrationEnabled,
            double soundVolume,
            double musicVolume,
            bool showGhost,
            bool showGrid,
            bool autoRepeat,
            int autoRepeatDelay,
            int autoRepeatRate,
            int softDropSpeed,
            bool showNextPieces,
            int nextPiecesCount,
            bool showHoldPiece,
            ControlScheme controlScheme,
            ThemeMode themeMode,
            String language,
            bool notifications,
            bool gameInvites,
            bool friendRequestsOnly)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            bool soundEnabled,
            bool musicEnabled,
            bool vibrationEnabled,
            double soundVolume,
            double musicVolume,
            bool showGhost,
            bool showGrid,
            bool autoRepeat,
            int autoRepeatDelay,
            int autoRepeatRate,
            int softDropSpeed,
            bool showNextPieces,
            int nextPiecesCount,
            bool showHoldPiece,
            ControlScheme controlScheme,
            ThemeMode themeMode,
            String language,
            bool notifications,
            bool gameInvites,
            bool friendRequestsOnly)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            bool soundEnabled,
            bool musicEnabled,
            bool vibrationEnabled,
            double soundVolume,
            double musicVolume,
            bool showGhost,
            bool showGrid,
            bool autoRepeat,
            int autoRepeatDelay,
            int autoRepeatRate,
            int softDropSpeed,
            bool showNextPieces,
            int nextPiecesCount,
            bool showHoldPiece,
            ControlScheme controlScheme,
            ThemeMode themeMode,
            String language,
            bool notifications,
            bool gameInvites,
            bool friendRequestsOnly)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserSettings value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserSettings value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserSettings value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) then) =
      _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call(
      {bool soundEnabled,
      bool musicEnabled,
      bool vibrationEnabled,
      double soundVolume,
      double musicVolume,
      bool showGhost,
      bool showGrid,
      bool autoRepeat,
      int autoRepeatDelay,
      int autoRepeatRate,
      int softDropSpeed,
      bool showNextPieces,
      int nextPiecesCount,
      bool showHoldPiece,
      ControlScheme controlScheme,
      ThemeMode themeMode,
      String language,
      bool notifications,
      bool gameInvites,
      bool friendRequestsOnly});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? soundEnabled = null,
    Object? musicEnabled = null,
    Object? vibrationEnabled = null,
    Object? soundVolume = null,
    Object? musicVolume = null,
    Object? showGhost = null,
    Object? showGrid = null,
    Object? autoRepeat = null,
    Object? autoRepeatDelay = null,
    Object? autoRepeatRate = null,
    Object? softDropSpeed = null,
    Object? showNextPieces = null,
    Object? nextPiecesCount = null,
    Object? showHoldPiece = null,
    Object? controlScheme = null,
    Object? themeMode = null,
    Object? language = null,
    Object? notifications = null,
    Object? gameInvites = null,
    Object? friendRequestsOnly = null,
  }) {
    return _then(_value.copyWith(
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      musicEnabled: null == musicEnabled
          ? _value.musicEnabled
          : musicEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      soundVolume: null == soundVolume
          ? _value.soundVolume
          : soundVolume // ignore: cast_nullable_to_non_nullable
              as double,
      musicVolume: null == musicVolume
          ? _value.musicVolume
          : musicVolume // ignore: cast_nullable_to_non_nullable
              as double,
      showGhost: null == showGhost
          ? _value.showGhost
          : showGhost // ignore: cast_nullable_to_non_nullable
              as bool,
      showGrid: null == showGrid
          ? _value.showGrid
          : showGrid // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRepeat: null == autoRepeat
          ? _value.autoRepeat
          : autoRepeat // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRepeatDelay: null == autoRepeatDelay
          ? _value.autoRepeatDelay
          : autoRepeatDelay // ignore: cast_nullable_to_non_nullable
              as int,
      autoRepeatRate: null == autoRepeatRate
          ? _value.autoRepeatRate
          : autoRepeatRate // ignore: cast_nullable_to_non_nullable
              as int,
      softDropSpeed: null == softDropSpeed
          ? _value.softDropSpeed
          : softDropSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      showNextPieces: null == showNextPieces
          ? _value.showNextPieces
          : showNextPieces // ignore: cast_nullable_to_non_nullable
              as bool,
      nextPiecesCount: null == nextPiecesCount
          ? _value.nextPiecesCount
          : nextPiecesCount // ignore: cast_nullable_to_non_nullable
              as int,
      showHoldPiece: null == showHoldPiece
          ? _value.showHoldPiece
          : showHoldPiece // ignore: cast_nullable_to_non_nullable
              as bool,
      controlScheme: null == controlScheme
          ? _value.controlScheme
          : controlScheme // ignore: cast_nullable_to_non_nullable
              as ControlScheme,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as bool,
      gameInvites: null == gameInvites
          ? _value.gameInvites
          : gameInvites // ignore: cast_nullable_to_non_nullable
              as bool,
      friendRequestsOnly: null == friendRequestsOnly
          ? _value.friendRequestsOnly
          : friendRequestsOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
          _$UserSettingsImpl value, $Res Function(_$UserSettingsImpl) then) =
      __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool soundEnabled,
      bool musicEnabled,
      bool vibrationEnabled,
      double soundVolume,
      double musicVolume,
      bool showGhost,
      bool showGrid,
      bool autoRepeat,
      int autoRepeatDelay,
      int autoRepeatRate,
      int softDropSpeed,
      bool showNextPieces,
      int nextPiecesCount,
      bool showHoldPiece,
      ControlScheme controlScheme,
      ThemeMode themeMode,
      String language,
      bool notifications,
      bool gameInvites,
      bool friendRequestsOnly});
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
      _$UserSettingsImpl _value, $Res Function(_$UserSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? soundEnabled = null,
    Object? musicEnabled = null,
    Object? vibrationEnabled = null,
    Object? soundVolume = null,
    Object? musicVolume = null,
    Object? showGhost = null,
    Object? showGrid = null,
    Object? autoRepeat = null,
    Object? autoRepeatDelay = null,
    Object? autoRepeatRate = null,
    Object? softDropSpeed = null,
    Object? showNextPieces = null,
    Object? nextPiecesCount = null,
    Object? showHoldPiece = null,
    Object? controlScheme = null,
    Object? themeMode = null,
    Object? language = null,
    Object? notifications = null,
    Object? gameInvites = null,
    Object? friendRequestsOnly = null,
  }) {
    return _then(_$UserSettingsImpl(
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      musicEnabled: null == musicEnabled
          ? _value.musicEnabled
          : musicEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      soundVolume: null == soundVolume
          ? _value.soundVolume
          : soundVolume // ignore: cast_nullable_to_non_nullable
              as double,
      musicVolume: null == musicVolume
          ? _value.musicVolume
          : musicVolume // ignore: cast_nullable_to_non_nullable
              as double,
      showGhost: null == showGhost
          ? _value.showGhost
          : showGhost // ignore: cast_nullable_to_non_nullable
              as bool,
      showGrid: null == showGrid
          ? _value.showGrid
          : showGrid // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRepeat: null == autoRepeat
          ? _value.autoRepeat
          : autoRepeat // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRepeatDelay: null == autoRepeatDelay
          ? _value.autoRepeatDelay
          : autoRepeatDelay // ignore: cast_nullable_to_non_nullable
              as int,
      autoRepeatRate: null == autoRepeatRate
          ? _value.autoRepeatRate
          : autoRepeatRate // ignore: cast_nullable_to_non_nullable
              as int,
      softDropSpeed: null == softDropSpeed
          ? _value.softDropSpeed
          : softDropSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      showNextPieces: null == showNextPieces
          ? _value.showNextPieces
          : showNextPieces // ignore: cast_nullable_to_non_nullable
              as bool,
      nextPiecesCount: null == nextPiecesCount
          ? _value.nextPiecesCount
          : nextPiecesCount // ignore: cast_nullable_to_non_nullable
              as int,
      showHoldPiece: null == showHoldPiece
          ? _value.showHoldPiece
          : showHoldPiece // ignore: cast_nullable_to_non_nullable
              as bool,
      controlScheme: null == controlScheme
          ? _value.controlScheme
          : controlScheme // ignore: cast_nullable_to_non_nullable
              as ControlScheme,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as bool,
      gameInvites: null == gameInvites
          ? _value.gameInvites
          : gameInvites // ignore: cast_nullable_to_non_nullable
              as bool,
      friendRequestsOnly: null == friendRequestsOnly
          ? _value.friendRequestsOnly
          : friendRequestsOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl(
      {this.soundEnabled = true,
      this.musicEnabled = true,
      this.vibrationEnabled = true,
      this.soundVolume = 0.7,
      this.musicVolume = 0.5,
      this.showGhost = true,
      this.showGrid = true,
      this.autoRepeat = false,
      this.autoRepeatDelay = 150,
      this.autoRepeatRate = 50,
      this.softDropSpeed = 500,
      this.showNextPieces = true,
      this.nextPiecesCount = 5,
      this.showHoldPiece = true,
      this.controlScheme = ControlScheme.classic,
      this.themeMode = ThemeMode.system,
      this.language = 'ko',
      this.notifications = true,
      this.gameInvites = true,
      this.friendRequestsOnly = false});

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool soundEnabled;
  @override
  @JsonKey()
  final bool musicEnabled;
  @override
  @JsonKey()
  final bool vibrationEnabled;
  @override
  @JsonKey()
  final double soundVolume;
  @override
  @JsonKey()
  final double musicVolume;
  @override
  @JsonKey()
  final bool showGhost;
  @override
  @JsonKey()
  final bool showGrid;
  @override
  @JsonKey()
  final bool autoRepeat;
  @override
  @JsonKey()
  final int autoRepeatDelay;
// 밀리초
  @override
  @JsonKey()
  final int autoRepeatRate;
// 밀리초
  @override
  @JsonKey()
  final int softDropSpeed;
// 밀리초
  @override
  @JsonKey()
  final bool showNextPieces;
  @override
  @JsonKey()
  final int nextPiecesCount;
  @override
  @JsonKey()
  final bool showHoldPiece;
  @override
  @JsonKey()
  final ControlScheme controlScheme;
  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final bool notifications;
  @override
  @JsonKey()
  final bool gameInvites;
  @override
  @JsonKey()
  final bool friendRequestsOnly;

  @override
  String toString() {
    return 'UserSettings(soundEnabled: $soundEnabled, musicEnabled: $musicEnabled, vibrationEnabled: $vibrationEnabled, soundVolume: $soundVolume, musicVolume: $musicVolume, showGhost: $showGhost, showGrid: $showGrid, autoRepeat: $autoRepeat, autoRepeatDelay: $autoRepeatDelay, autoRepeatRate: $autoRepeatRate, softDropSpeed: $softDropSpeed, showNextPieces: $showNextPieces, nextPiecesCount: $nextPiecesCount, showHoldPiece: $showHoldPiece, controlScheme: $controlScheme, themeMode: $themeMode, language: $language, notifications: $notifications, gameInvites: $gameInvites, friendRequestsOnly: $friendRequestsOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.musicEnabled, musicEnabled) ||
                other.musicEnabled == musicEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.soundVolume, soundVolume) ||
                other.soundVolume == soundVolume) &&
            (identical(other.musicVolume, musicVolume) ||
                other.musicVolume == musicVolume) &&
            (identical(other.showGhost, showGhost) ||
                other.showGhost == showGhost) &&
            (identical(other.showGrid, showGrid) ||
                other.showGrid == showGrid) &&
            (identical(other.autoRepeat, autoRepeat) ||
                other.autoRepeat == autoRepeat) &&
            (identical(other.autoRepeatDelay, autoRepeatDelay) ||
                other.autoRepeatDelay == autoRepeatDelay) &&
            (identical(other.autoRepeatRate, autoRepeatRate) ||
                other.autoRepeatRate == autoRepeatRate) &&
            (identical(other.softDropSpeed, softDropSpeed) ||
                other.softDropSpeed == softDropSpeed) &&
            (identical(other.showNextPieces, showNextPieces) ||
                other.showNextPieces == showNextPieces) &&
            (identical(other.nextPiecesCount, nextPiecesCount) ||
                other.nextPiecesCount == nextPiecesCount) &&
            (identical(other.showHoldPiece, showHoldPiece) ||
                other.showHoldPiece == showHoldPiece) &&
            (identical(other.controlScheme, controlScheme) ||
                other.controlScheme == controlScheme) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.gameInvites, gameInvites) ||
                other.gameInvites == gameInvites) &&
            (identical(other.friendRequestsOnly, friendRequestsOnly) ||
                other.friendRequestsOnly == friendRequestsOnly));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        soundEnabled,
        musicEnabled,
        vibrationEnabled,
        soundVolume,
        musicVolume,
        showGhost,
        showGrid,
        autoRepeat,
        autoRepeatDelay,
        autoRepeatRate,
        softDropSpeed,
        showNextPieces,
        nextPiecesCount,
        showHoldPiece,
        controlScheme,
        themeMode,
        language,
        notifications,
        gameInvites,
        friendRequestsOnly
      ]);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool soundEnabled,
            bool musicEnabled,
            bool vibrationEnabled,
            double soundVolume,
            double musicVolume,
            bool showGhost,
            bool showGrid,
            bool autoRepeat,
            int autoRepeatDelay,
            int autoRepeatRate,
            int softDropSpeed,
            bool showNextPieces,
            int nextPiecesCount,
            bool showHoldPiece,
            ControlScheme controlScheme,
            ThemeMode themeMode,
            String language,
            bool notifications,
            bool gameInvites,
            bool friendRequestsOnly)
        $default,
  ) {
    return $default(
        soundEnabled,
        musicEnabled,
        vibrationEnabled,
        soundVolume,
        musicVolume,
        showGhost,
        showGrid,
        autoRepeat,
        autoRepeatDelay,
        autoRepeatRate,
        softDropSpeed,
        showNextPieces,
        nextPiecesCount,
        showHoldPiece,
        controlScheme,
        themeMode,
        language,
        notifications,
        gameInvites,
        friendRequestsOnly);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            bool soundEnabled,
            bool musicEnabled,
            bool vibrationEnabled,
            double soundVolume,
            double musicVolume,
            bool showGhost,
            bool showGrid,
            bool autoRepeat,
            int autoRepeatDelay,
            int autoRepeatRate,
            int softDropSpeed,
            bool showNextPieces,
            int nextPiecesCount,
            bool showHoldPiece,
            ControlScheme controlScheme,
            ThemeMode themeMode,
            String language,
            bool notifications,
            bool gameInvites,
            bool friendRequestsOnly)?
        $default,
  ) {
    return $default?.call(
        soundEnabled,
        musicEnabled,
        vibrationEnabled,
        soundVolume,
        musicVolume,
        showGhost,
        showGrid,
        autoRepeat,
        autoRepeatDelay,
        autoRepeatRate,
        softDropSpeed,
        showNextPieces,
        nextPiecesCount,
        showHoldPiece,
        controlScheme,
        themeMode,
        language,
        notifications,
        gameInvites,
        friendRequestsOnly);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            bool soundEnabled,
            bool musicEnabled,
            bool vibrationEnabled,
            double soundVolume,
            double musicVolume,
            bool showGhost,
            bool showGrid,
            bool autoRepeat,
            int autoRepeatDelay,
            int autoRepeatRate,
            int softDropSpeed,
            bool showNextPieces,
            int nextPiecesCount,
            bool showHoldPiece,
            ControlScheme controlScheme,
            ThemeMode themeMode,
            String language,
            bool notifications,
            bool gameInvites,
            bool friendRequestsOnly)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          soundEnabled,
          musicEnabled,
          vibrationEnabled,
          soundVolume,
          musicVolume,
          showGhost,
          showGrid,
          autoRepeat,
          autoRepeatDelay,
          autoRepeatRate,
          softDropSpeed,
          showNextPieces,
          nextPiecesCount,
          showHoldPiece,
          controlScheme,
          themeMode,
          language,
          notifications,
          gameInvites,
          friendRequestsOnly);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserSettings value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserSettings value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserSettings value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(
      this,
    );
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings(
      {final bool soundEnabled,
      final bool musicEnabled,
      final bool vibrationEnabled,
      final double soundVolume,
      final double musicVolume,
      final bool showGhost,
      final bool showGrid,
      final bool autoRepeat,
      final int autoRepeatDelay,
      final int autoRepeatRate,
      final int softDropSpeed,
      final bool showNextPieces,
      final int nextPiecesCount,
      final bool showHoldPiece,
      final ControlScheme controlScheme,
      final ThemeMode themeMode,
      final String language,
      final bool notifications,
      final bool gameInvites,
      final bool friendRequestsOnly}) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  @override
  bool get soundEnabled;
  @override
  bool get musicEnabled;
  @override
  bool get vibrationEnabled;
  @override
  double get soundVolume;
  @override
  double get musicVolume;
  @override
  bool get showGhost;
  @override
  bool get showGrid;
  @override
  bool get autoRepeat;
  @override
  int get autoRepeatDelay; // 밀리초
  @override
  int get autoRepeatRate; // 밀리초
  @override
  int get softDropSpeed; // 밀리초
  @override
  bool get showNextPieces;
  @override
  int get nextPiecesCount;
  @override
  bool get showHoldPiece;
  @override
  ControlScheme get controlScheme;
  @override
  ThemeMode get themeMode;
  @override
  String get language;
  @override
  bool get notifications;
  @override
  bool get gameInvites;
  @override
  bool get friendRequestsOnly;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
