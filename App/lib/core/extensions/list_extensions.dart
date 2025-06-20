import 'dart:math';

extension ListExtensions<T> on List<T> {
  // 안전한 접근
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
  
  T? elementAtOrNull(int index) {
    return index >= 0 && index < length ? this[index] : null;
  }
  
  T? get secondOrNull => length >= 2 ? this[1] : null;
  T? get thirdOrNull => length >= 3 ? this[2] : null;

  // 조건부 필터링
  List<T> whereNotNull() {
    return where((element) => element != null).toList();
  }
  
  List<T> whereIndexed(bool Function(T element, int index) test) {
    final result = <T>[];
    for (int i = 0; i < length; i++) {
      if (test(this[i], i)) {
        result.add(this[i]);
      }
    }
    return result;
  }

  // 변환
  List<R> mapIndexed<R>(R Function(T element, int index) mapper) {
    final result = <R>[];
    for (int i = 0; i < length; i++) {
      result.add(mapper(this[i], i));
    }
    return result;
  }
  
  Map<K, List<T>> groupBy<K>(K Function(T element) keySelector) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => <T>[]).add(element);
    }
    return map;
  }
  
  Map<K, T> associateBy<K>(K Function(T element) keySelector) {
    final map = <K, T>{};
    for (final element in this) {
      map[keySelector(element)] = element;
    }
    return map;
  }

  // 청킹과 파티셔닝
  List<List<T>> chunk(int size) {
    if (size <= 0) throw ArgumentError('Size must be positive');
    
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
  
  List<List<T>> partition(bool Function(T element) predicate) {
    final truthy = <T>[];
    final falsy = <T>[];
    
    for (final element in this) {
      if (predicate(element)) {
        truthy.add(element);
      } else {
        falsy.add(element);
      }
    }
    
    return [truthy, falsy];
  }

  // 고유값과 중복 제거
  List<T> distinct() {
    return toSet().toList();
  }
  
  List<T> distinctBy<K>(K Function(T element) keySelector) {
    final seen = <K>{};
    final result = <T>[];
    
    for (final element in this) {
      final key = keySelector(element);
      if (seen.add(key)) {
        result.add(element);
      }
    }
    
    return result;
  }

  // 수학적 연산 (숫자 리스트용)
  T? max([int Function(T a, T b)? compare]) {
    if (isEmpty) return null;
    return reduce((a, b) => (compare ?? Comparable.compare as int Function(T, T))(a, b) > 0 ? a : b);
  }
  
  T? min([int Function(T a, T b)? compare]) {
    if (isEmpty) return null;
    return reduce((a, b) => (compare ?? Comparable.compare as int Function(T, T))(a, b) < 0 ? a : b);
  }

  // 검색과 찾기
  int? indexWhereOrNull(bool Function(T element) test) {
    final index = indexWhere(test);
    return index == -1 ? null : index;
  }
  
  T? firstWhereOrNull(bool Function(T element) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }
  
  T? lastWhereOrNull(bool Function(T element) test) {
    try {
      return lastWhere(test);
    } catch (e) {
      return null;
    }
  }

  // 무작위
  T? get randomOrNull {
    if (isEmpty) return null;
    final random = Random();
    return this[random.nextInt(length)];
  }
  
  List<T> shuffled() {
    final copy = List<T>.from(this);
    copy.shuffle();
    return copy;
  }
  
  List<T> sample(int count) {
    if (count >= length) return shuffled();
    return shuffled().take(count).toList();
  }

  // 교차와 차집합
  List<T> intersect(Iterable<T> other) {
    final otherSet = other.toSet();
    return where(otherSet.contains).toList();
  }
  
  List<T> subtract(Iterable<T> other) {
    final otherSet = other.toSet();
    return where((element) => !otherSet.contains(element)).toList();
  }
  
  List<T> union(Iterable<T> other) {
    return {...this, ...other}.toList();
  }

  // 윈도우와 슬라이딩
  List<List<T>> windowed(int size, {int step = 1}) {
    if (size <= 0 || step <= 0) throw ArgumentError('Size and step must be positive');
    
    final windows = <List<T>>[];
    for (int i = 0; i <= length - size; i += step) {
      windows.add(sublist(i, i + size));
    }
    return windows;
  }
  
  List<T> sliding(int windowSize) {
    if (windowSize <= 0) throw ArgumentError('Window size must be positive');
    if (length < windowSize) return [];
    
    return sublist(length - windowSize);
  }

  // 조건부 연산
  List<T> takeWhileIndexed(bool Function(T element, int index) test) {
    final result = <T>[];
    for (int i = 0; i < length; i++) {
      if (test(this[i], i)) {
        result.add(this[i]);
      } else {
        break;
      }
    }
    return result;
  }
  
  List<T> dropWhileIndexed(bool Function(T element, int index) test) {
    int startIndex = 0;
    for (int i = 0; i < length; i++) {
      if (test(this[i], i)) {
        startIndex = i + 1;
      } else {
        break;
      }
    }
    return sublist(startIndex);
  }

  // 집계
  R aggregate<R>(R initialValue, R Function(R accumulator, T element) operation) {
    R result = initialValue;
    for (final element in this) {
      result = operation(result, element);
    }
    return result;
  }
  
  R aggregateIndexed<R>(R initialValue, R Function(R accumulator, T element, int index) operation) {
    R result = initialValue;
    for (int i = 0; i < length; i++) {
      result = operation(result, this[i], i);
    }
    return result;
  }

  // 회전과 시프트
  List<T> rotateLeft(int positions) {
    if (isEmpty) return [];
    final pos = positions % length;
    return [...sublist(pos), ...sublist(0, pos)];
  }
  
  List<T> rotateRight(int positions) {
    if (isEmpty) return [];
    final pos = positions % length;
    return [...sublist(length - pos), ...sublist(0, length - pos)];
  }

  // 플래튼
  List<R> flatMap<R>(Iterable<R> Function(T element) mapper) {
    return expand(mapper).toList();
  }

  // 지연 평가
  Iterable<T> lazyWhere(bool Function(T element) test) sync* {
    for (final element in this) {
      if (test(element)) {
        yield element;
      }
    }
  }
  
  Iterable<R> lazyMap<R>(R Function(T element) mapper) sync* {
    for (final element in this) {
      yield mapper(element);
    }
  }
}

extension ListNumberExtensions<T extends num> on List<T> {
  T get sum => isEmpty ? 0 as T : reduce((a, b) => (a + b) as T);
  
  double get average => isEmpty ? 0.0 : sum / length;
  
  T get maximum => reduce((a, b) => a > b ? a : b);
  
  T get minimum => reduce((a, b) => a < b ? a : b);
  
  double get median {
    if (isEmpty) return 0.0;
    final sorted = [...this]..sort();
    final middle = sorted.length ~/ 2;
    
    if (sorted.length.isOdd) {
      return sorted[middle].toDouble();
    } else {
      return (sorted[middle - 1] + sorted[middle]) / 2;
    }
  }
  
  double get standardDeviation {
    if (length < 2) return 0.0;
    final mean = average;
    final variance = map((x) => (x - mean) * (x - mean)).sum / (length - 1);
    return sqrt(variance);
  }
}

extension ListStringExtensions on List<String> {
  String join([String separator = '']) => super.join(separator);
  
  String get csv => join(', ');
  
  String get lines => join('\n');
  
  List<String> get trimmed => map((s) => s.trim()).toList();
  
  List<String> get nonEmpty => where((s) => s.isNotEmpty).toList();
  
  List<String> get lowercased => map((s) => s.toLowerCase()).toList();
  
  List<String> get uppercased => map((s) => s.toUpperCase()).toList();
  
  List<String> get capitalized => map((s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1)).toList();
}

// 게임 특화 확장
extension GameListExtensions<T> on List<T> {
  /// 7-bag 시스템을 위한 셔플 (테트리스용)
  List<T> bagShuffle() {
    if (length != 7) throw ArgumentError('Bag shuffle requires exactly 7 elements');
    return shuffled();
  }
  
  /// 순환 큐처럼 동작
  T getCircular(int index) {
    if (isEmpty) throw StateError('List is empty');
    return this[index % length];
  }
  
  /// 히스토리 관리 (최대 크기 제한)
  List<T> addWithLimit(T item, int maxSize) {
    final newList = [item, ...this];
    return newList.length > maxSize ? newList.sublist(0, maxSize) : newList;
  }
}
