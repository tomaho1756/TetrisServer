import 'package:intl/intl.dart';

class Formatters {
  // 점수 포맷팅
  static String formatScore(int score) {
    if (score >= 1000000000) {
      return '${(score / 1000000000).toStringAsFixed(1)}B';
    } else if (score >= 1000000) {
      return '${(score / 1000000).toStringAsFixed(1)}M';
    } else if (score >= 1000) {
      return '${(score / 1000).toStringAsFixed(1)}K';
    }
    return NumberFormat('#,###').format(score);
  }

  // 시간 포맷팅
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  // 게임 시간 포맷팅 (MM:SS)
  static String formatGameTime(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // 밀리초 포함 시간 포맷팅 (MM:SS.mmm)
  static String formatPreciseTime(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final milliseconds = duration.inMilliseconds.remainder(1000);
    return '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}.'
           '${milliseconds.toString().padLeft(3, '0')}';
  }

  // 날짜 포맷팅
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return '오늘 ${DateFormat('HH:mm').format(date)}';
    } else if (dateToCheck == yesterday) {
      return '어제 ${DateFormat('HH:mm').format(date)}';
    } else if (now.difference(date).inDays < 7) {
      final weekdays = ['월', '화', '수', '목', '금', '토', '일'];
      return '${weekdays[date.weekday - 1]}요일 ${DateFormat('HH:mm').format(date)}';
    } else if (date.year == now.year) {
      return DateFormat('M월 d일 HH:mm').format(date);
    } else {
      return DateFormat('yyyy년 M월 d일').format(date);
    }
  }

  // 상대 시간 포맷팅 (몇 분 전, 몇 시간 전 등)
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}주 전';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}개월 전';
    } else {
      return '${(difference.inDays / 365).floor()}년 전';
    }
  }

  // 파일 크기 포맷팅
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  // 퍼센트 포맷팅
  static String formatPercentage(double value, {int decimals = 1}) {
    return '${(value * 100).toStringAsFixed(decimals)}%';
  }

  // 승률 포맷팅
  static String formatWinRate(int wins, int totalGames) {
    if (totalGames == 0) return '0%';
    final rate = (wins / totalGames) * 100;
    return '${rate.toStringAsFixed(1)}%';
  }

  // PPS (Pieces Per Second) 포맷팅
  static String formatPPS(int pieces, Duration duration) {
    if (duration.inSeconds == 0) return '0.0';
    final pps = pieces / duration.inSeconds;
    return pps.toStringAsFixed(1);
  }

  // APM (Actions Per Minute) 포맷팅
  static String formatAPM(int actions, Duration duration) {
    if (duration.inMinutes == 0) return '0';
    final apm = actions / duration.inMinutes;
    return apm.toStringAsFixed(0);
  }

  // 레벨 포맷팅
  static String formatLevel(int level) {
    return 'Level $level';
  }

  // 라인 포맷팅
  static String formatLines(int lines) {
    return NumberFormat('#,###').format(lines);
  }

  // 게임 모드 이름 포맷팅
  static String formatGameMode(String mode) {
    switch (mode) {
      case 'classic':
        return '클래식';
      case 'sprint':
        return '스프린트';
      case 'battle':
        return '배틀';
      case 'endless':
        return '엔드리스';
      case 'multiplayer':
        return '멀티플레이어';
      default:
        return mode;
    }
  }

  // 게임 상태 포맷팅
  static String formatGameStatus(String status) {
    switch (status) {
      case 'waiting':
        return '대기중';
      case 'playing':
        return '게임중';
      case 'finished':
        return '완료';
      case 'paused':
        return '일시정지';
      case 'cancelled':
        return '취소됨';
      default:
        return status;
    }
  }

  // 플레이어 상태 포맷팅
  static String formatPlayerStatus(String status) {
    switch (status) {
      case 'online':
        return '온라인';
      case 'offline':
        return '오프라인';
      case 'playing':
        return '게임중';
      case 'idle':
        return '자리비움';
      default:
        return status;
    }
  }

  // 순위 포맷팅
  static String formatRank(int rank) {
    if (rank <= 0) return '-';
    
    if (rank == 1) return '🥇 1등';
    if (rank == 2) return '🥈 2등';
    if (rank == 3) return '🥉 3등';
    
    return '#$rank';
  }

  // 숫자를 서수로 포맷팅 (1st, 2nd, 3rd, etc.)
  static String formatOrdinal(int number) {
    if (number <= 0) return '$number';
    
    final lastTwoDigits = number % 100;
    final lastDigit = number % 10;
    
    if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
      return '${number}th';
    }
    
    switch (lastDigit) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  // 통화 포맷팅 (코인 등)
  static String formatCurrency(int amount, {String symbol = '🪙'}) {
    return '$symbol ${NumberFormat('#,###').format(amount)}';
  }

  // 배수 포맷팅
  static String formatMultiplier(double multiplier) {
    return '×${multiplier.toStringAsFixed(1)}';
  }

  // 키 바인딩 포맷팅
  static String formatKeyBinding(String key) {
    switch (key.toLowerCase()) {
      case 'space':
        return 'Space';
      case 'enter':
        return 'Enter';
      case 'shift':
        return 'Shift';
      case 'ctrl':
        return 'Ctrl';
      case 'alt':
        return 'Alt';
      case 'arrowup':
        return '↑';
      case 'arrowdown':
        return '↓';
      case 'arrowleft':
        return '←';
      case 'arrowright':
        return '→';
      default:
        return key.toUpperCase();
    }
  }

  // 네트워크 지연시간 포맷팅
  static String formatPing(int milliseconds) {
    if (milliseconds < 50) {
      return '$milliseconds ms (우수)';
    } else if (milliseconds < 100) {
      return '$milliseconds ms (양호)';
    } else if (milliseconds < 200) {
      return '$milliseconds ms (보통)';
    } else {
      return '$milliseconds ms (느림)';
    }
  }

  // 텍스트 줄임 처리
  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength - suffix.length) + suffix;
  }

  // 카멜케이스를 띄어쓰기로 변환
  static String camelCaseToWords(String camelCase) {
    return camelCase
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim();
  }

  // 스네이크케이스를 띄어쓰기로 변환
  static String snakeCaseToWords(String snakeCase) {
    return snakeCase.replaceAll('_', ' ');
  }

  // 첫 글자 대문자
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // 각 단어의 첫 글자 대문자
  static String titleCase(String text) {
    return text.split(' ').map(capitalize).join(' ');
  }
}
