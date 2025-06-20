extension StringExtensions on String {
  // 유효성 검사
  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
  
  bool get isPhoneNumber {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(this);
  }
  
  bool get isUrl {
    return RegExp(r'^https?:\/\/[^\s/$.?#].[^\s]*$').hasMatch(this);
  }
  
  bool get isNumeric {
    return double.tryParse(this) != null;
  }
  
  bool get isAlphabetic {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }
  
  bool get isAlphanumeric {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  // 변환
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
  
  String get titleCase {
    return split(' ').map((word) => word.capitalize).join(' ');
  }
  
  String get camelCase {
    final words = split(' ');
    if (words.isEmpty) return this;
    
    return words.first.toLowerCase() + 
           words.skip(1).map((word) => word.capitalize).join();
  }
  
  String get snakeCase {
    return replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)}_${match.group(2)?.toLowerCase()}',
    ).toLowerCase();
  }
  
  String get kebabCase {
    return replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)}-${match.group(2)?.toLowerCase()}',
    ).toLowerCase();
  }

  // 포맷팅
  String truncate(int maxLength, [String suffix = '...']) {
    if (length <= maxLength) return this;
    return substring(0, maxLength - suffix.length) + suffix;
  }
  
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');
  
  String get removeSpecialChars => replaceAll(RegExp(r'[^\w\s]'), '');
  
  String get onlyNumbers => replaceAll(RegExp(r'[^\d]'), '');
  
  String get onlyLetters => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  // 암호화/해싱 (간단한 버전)
  String get reversed => split('').reversed.join();
  
  int get hashCode {
    int hash = 0;
    for (int i = 0; i < length; i++) {
      hash = ((hash << 5) - hash) + codeUnitAt(i);
      hash = hash & hash; // 32bit로 제한
    }
    return hash;
  }

  // 유틸리티
  bool get isNotEmpty => trim().isNotEmpty;
  
  bool get isBlank => trim().isEmpty;
  
  String get orEmpty => this;
  
  String ifEmpty(String defaultValue) => isEmpty ? defaultValue : this;
  
  String? get nullIfEmpty => isEmpty ? null : this;

  // 숫자 변환
  int? get toInt => int.tryParse(this);
  
  double? get toDouble => double.tryParse(this);
  
  bool? get toBool {
    final lower = toLowerCase();
    if (lower == 'true' || lower == '1') return true;
    if (lower == 'false' || lower == '0') return false;
    return null;
  }

  // 문자열 분석
  int get wordCount => trim().isEmpty ? 0 : trim().split(RegExp(r'\s+')).length;
  
  int get lineCount => split('\n').length;
  
  Map<String, int> get characterFrequency {
    final Map<String, int> frequency = {};
    for (int i = 0; i < length; i++) {
      final char = this[i];
      frequency[char] = (frequency[char] ?? 0) + 1;
    }
    return frequency;
  }

  // 거리 계산 (레벤시타인 거리)
  int levenshteinDistance(String other) {
    if (length == 0) return other.length;
    if (other.length == 0) return length;

    final matrix = List.generate(
      length + 1,
      (i) => List.filled(other.length + 1, 0),
    );

    for (int i = 0; i <= length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= other.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= length; i++) {
      for (int j = 1; j <= other.length; j++) {
        final cost = this[i - 1] == other[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[length][other.length];
  }

  // 유사도 계산
  double similarity(String other) {
    final maxLength = [length, other.length].reduce((a, b) => a > b ? a : b);
    if (maxLength == 0) return 1.0;
    
    final distance = levenshteinDistance(other);
    return 1.0 - (distance / maxLength);
  }

  // 마스킹
  String mask({String maskChar = '*', int start = 0, int? end}) {
    final endIndex = end ?? length;
    if (start < 0 || endIndex > length || start >= endIndex) return this;
    
    return substring(0, start) + 
           maskChar * (endIndex - start) + 
           substring(endIndex);
  }
  
  String maskEmail() {
    if (!isEmail) return this;
    
    final parts = split('@');
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) {
      return mask(end: username.length) + '@' + domain;
    }
    
    return username.substring(0, 2) + 
           '*' * (username.length - 2) + 
           '@' + domain;
  }

  // 색상 변환
  int? get hexToInt {
    String hex = replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return int.tryParse(hex, radix: 16);
  }

  // Base64 인코딩/디코딩 헬퍼
  String get base64Encoded {
    final bytes = codeUnits;
    return base64.encode(bytes);
  }
  
  String get base64Decoded {
    try {
      final bytes = base64.decode(this);
      return String.fromCharCodes(bytes);
    } catch (e) {
      return this;
    }
  }

  // 템플릿 문자열
  String format(Map<String, dynamic> params) {
    String result = this;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }
  
  String formatArgs(List<dynamic> args) {
    String result = this;
    for (int i = 0; i < args.length; i++) {
      result = result.replaceAll('{$i}', args[i].toString());
    }
    return result;
  }

  // 정규식 헬퍼
  bool matches(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }
  
  List<String> extractMatches(String pattern) {
    final regex = RegExp(pattern);
    return regex.allMatches(this).map((match) => match.group(0)!).toList();
  }
  
  String replacePattern(String pattern, String replacement) {
    return replaceAll(RegExp(pattern), replacement);
  }

  // 파일 경로 헬퍼
  String get fileName {
    return split('/').last;
  }
  
  String get fileExtension {
    final name = fileName;
    final dotIndex = name.lastIndexOf('.');
    return dotIndex != -1 ? name.substring(dotIndex + 1) : '';
  }
  
  String get fileNameWithoutExtension {
    final name = fileName;
    final dotIndex = name.lastIndexOf('.');
    return dotIndex != -1 ? name.substring(0, dotIndex) : name;
  }
}

extension StringNullableExtensions on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;
  
  bool get isNotNullOrEmpty => !isNullOrEmpty;
  
  String get orEmpty => this ?? '';
  
  String orElse(String defaultValue) => this ?? defaultValue;
  
  String? get nullIfEmpty => (this?.isEmpty ?? true) ? null : this;
}
