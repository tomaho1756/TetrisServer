import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Helpers {
  // 랜덤 유틸리티
  static final Random _random = Random();
  
  static int randomInt(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }
  
  static double randomDouble(double min, double max) {
    return min + _random.nextDouble() * (max - min);
  }
  
  static bool randomBool() {
    return _random.nextBool();
  }
  
  static T randomElement<T>(List<T> list) {
    if (list.isEmpty) throw ArgumentError('List cannot be empty');
    return list[_random.nextInt(list.length)];
  }
  
  static List<T> shuffleList<T>(List<T> list) {
    final shuffled = List<T>.from(list);
    shuffled.shuffle(_random);
    return shuffled;
  }

  // 색상 유틸리티
  static Color lightenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
  
  static Color darkenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
  
  static Color blendColors(Color color1, Color color2, double ratio) {
    assert(ratio >= 0 && ratio <= 1);
    return Color.lerp(color1, color2, ratio)!;
  }
  
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
  
  static Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  // 디바이스 정보
  static bool isTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 600;
  }
  
  static bool isDesktop(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 1200;
  }
  
  static bool isSmallScreen(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600;
  }
  
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // 진동 유틸리티
  static Future<void> lightHaptic() async {
    await HapticFeedback.lightImpact();
  }
  
  static Future<void> mediumHaptic() async {
    await HapticFeedback.mediumImpact();
  }
  
  static Future<void> heavyHaptic() async {
    await HapticFeedback.heavyImpact();
  }
  
  static Future<void> selectionHaptic() async {
    await HapticFeedback.selectionClick();
  }

  // 키보드 유틸리티
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
  
  static void showKeyboard(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  // 딜레이 유틸리티
  static Future<void> delay(Duration duration) {
    return Future.delayed(duration);
  }
  
  static Future<T> debounce<T>(
    Future<T> Function() function,
    Duration delay,
  ) async {
    await Future.delayed(delay);
    return function();
  }

  // 네트워크 연결 확인
  static bool hasNetworkConnection = true; // 실제로는 connectivity 패키지 사용

  // 문자열 유틸리티
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
  
  static String generateRandomString(int length) {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(_random.nextInt(chars.length)),
    ));
  }
  
  static String generateUUID() {
    // 간단한 UUID 생성 (실제로는 uuid 패키지 사용 권장)
    final random = Random();
    final hex = '0123456789abcdef';
    String uuid = '';
    
    for (int i = 0; i < 36; i++) {
      if (i == 8 || i == 13 || i == 18 || i == 23) {
        uuid += '-';
      } else if (i == 14) {
        uuid += '4';
      } else if (i == 19) {
        uuid += hex[(random.nextInt(4) + 8)];
      } else {
        uuid += hex[random.nextInt(16)];
      }
    }
    
    return uuid;
  }

  // 수학 유틸리티
  static double clamp(double value, double min, double max) {
    return value.clamp(min, max);
  }
  
  static int clampInt(int value, int min, int max) {
    return value.clamp(min, max);
  }
  
  static double lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }
  
  static double distance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }
  
  static double degreeToRadian(double degree) {
    return degree * pi / 180;
  }
  
  static double radianToDegree(double radian) {
    return radian * 180 / pi;
  }

  // 리스트 유틸리티
  static List<T> chunk<T>(List<T> list, int size) {
    if (size <= 0) throw ArgumentError('Size must be positive');
    
    final chunks = <List<T>>[];
    for (int i = 0; i < list.length; i += size) {
      chunks.add(list.sublist(i, min(i + size, list.length)));
    }
    return chunks.expand((chunk) => [chunk]).toList();
  }
  
  static Map<K, List<V>> groupBy<K, V>(List<V> list, K Function(V) keyFunction) {
    final map = <K, List<V>>{};
    for (final item in list) {
      final key = keyFunction(item);
      map.putIfAbsent(key, () => <V>[]).add(item);
    }
    return map;
  }
  
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  // 애니메이션 유틸리티
  static AnimationController createAnimationController({
    required TickerProvider vsync,
    required Duration duration,
    double initialValue = 0.0,
  }) {
    return AnimationController(
      vsync: vsync,
      duration: duration,
      value: initialValue,
    );
  }
  
  static Animation<double> createTween({
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
    Curve curve = Curves.linear,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));
  }

  // 로깅 유틸리티
  static void logDebug(String message) {
    debugPrint('🐛 DEBUG: $message');
  }
  
  static void logInfo(String message) {
    debugPrint('ℹ️ INFO: $message');
  }
  
  static void logWarning(String message) {
    debugPrint('⚠️ WARNING: $message');
  }
  
  static void logError(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('❌ ERROR: $message');
    if (error != null) {
      debugPrint('Error details: $error');
    }
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  // 성능 측정
  static Future<T> measurePerformance<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    final stopwatch = Stopwatch()..start();
    try {
      final result = await operation();
      stopwatch.stop();
      logInfo('$operationName took ${stopwatch.elapsedMilliseconds}ms');
      return result;
    } catch (e) {
      stopwatch.stop();
      logError('$operationName failed after ${stopwatch.elapsedMilliseconds}ms', e);
      rethrow;
    }
  }

  // 쓰로틀링 유틸리티
  static Timer? _throttleTimer;
  
  static void throttle(Duration duration, VoidCallback callback) {
    if (_throttleTimer?.isActive ?? false) return;
    
    _throttleTimer = Timer(duration, callback);
  }

  // 날짜 유틸리티
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
  
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }
  
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }
  
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
  
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  // 게임 관련 유틸리티
  static int calculateLevel(int linesCleared) {
    return (linesCleared / 10).floor();
  }
  
  static int calculateLevelSpeed(int level) {
    // 레벨별 낙하 속도 계산 (밀리초)
    if (level < 9) {
      return 1000 - (level * 100);
    } else if (level < 19) {
      return 100 - ((level - 9) * 10);
    } else {
      return 20;
    }
  }
  
  static int calculateScore(int linesCleared, int level, bool isTSpin) {
    const baseScores = [0, 100, 300, 500, 800];
    int score = baseScores[linesCleared] * (level + 1);
    
    if (isTSpin) {
      score = score * (linesCleared == 0 ? 4 : 3);
    }
    
    return score;
  }
}

// 타이머 유틸리티
class Timer {
  static Timer? _current;
  
  static Timer periodic(Duration duration, VoidCallback callback) {
    return Timer.periodic(duration, (_) => callback());
  }
  
  static void cancel() {
    _current?.cancel();
    _current = null;
  }
}

// 디바운서 클래스
class Debouncer {
  final Duration delay;
  Timer? _timer;
  
  Debouncer({required this.delay});
  
  void call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }
  
  void dispose() {
    _timer?.cancel();
  }
}

// 쓰로틀러 클래스
class Throttler {
  final Duration duration;
  Timer? _timer;
  bool _isThrottled = false;
  
  Throttler({required this.duration});
  
  void call(VoidCallback callback) {
    if (_isThrottled) return;
    
    callback();
    _isThrottled = true;
    
    _timer = Timer(duration, () {
      _isThrottled = false;
    });
  }
  
  void dispose() {
    _timer?.cancel();
  }
}

// 결과 래퍼 클래스
class Result<T> {
  final T? data;
  final String? error;
  final bool isSuccess;
  
  const Result._({this.data, this.error, required this.isSuccess});
  
  factory Result.success(T data) {
    return Result._(data: data, isSuccess: true);
  }
  
  factory Result.failure(String error) {
    return Result._(error: error, isSuccess: false);
  }
  
  bool get isFailure => !isSuccess;
}
