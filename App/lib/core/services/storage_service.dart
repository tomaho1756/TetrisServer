import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();
  StorageService._internal();
  
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('StorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // 기존 BLoC에서 사용하는 인터페이스에 맞춤
  Future<String?> getToken() async {
    return prefs.getString('auth_token');
  }

  Future<void> saveToken(String token) async {
    await prefs.setString('auth_token', token);
  }

  Future<void> removeToken() async {
    await prefs.remove('auth_token');
  }

  // 일반적인 저장소 메서드들
  Future<String?> getString(String key) async {
    return prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  Future<int?> getInt(String key) async {
    return prefs.getInt(key);
  }

  Future<void> setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  Future<bool?> getBool(String key) async {
    return prefs.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  Future<double?> getDouble(String key) async {
    return prefs.getDouble(key);
  }

  Future<void> setDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    return prefs.getStringList(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  // JSON 객체 저장/로드
  Future<Map<String, dynamic>?> getJson(String key) async {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    await prefs.setString(key, jsonString);
  }

  // 키 존재 여부 확인
  bool containsKey(String key) {
    return prefs.containsKey(key);
  }

  // 키 제거
  Future<void> remove(String key) async {
    await prefs.remove(key);
  }

  // 모든 데이터 제거
  Future<void> clear() async {
    await prefs.clear();
  }

  // 모든 키 가져오기
  Set<String> getKeys() {
    return prefs.getKeys();
  }

  // 사용자 관련 저장소
  Future<void> saveUserId(String userId) async {
    await setString('user_id', userId);
  }

  Future<String?> getUserId() async {
    return getString('user_id');
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await setJson('user_data', userData);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    return getJson('user_data');
  }

  // 게임 관련 저장소
  Future<void> saveHighScore(int score) async {
    await setInt('high_score', score);
  }

  Future<int> getHighScore() async {
    return (await getInt('high_score')) ?? 0;
  }

  Future<void> saveGameStats(Map<String, dynamic> stats) async {
    await setJson('game_stats', stats);
  }

  Future<Map<String, dynamic>?> getGameStats() async {
    return getJson('game_stats');
  }

  // 게임 기록
  Future<void> saveGameRecord(Map<String, dynamic> record) async {
    final records = await getGameRecords();
    records.add(record);
    
    // 최근 50개만 유지
    if (records.length > 50) {
      records.removeRange(0, records.length - 50);
    }
    
    await setJson('game_records', {'records': records});
  }

  Future<List<Map<String, dynamic>>> getGameRecords() async {
    final data = await getJson('game_records');
    if (data == null || data['records'] == null) return [];
    
    try {
      return List<Map<String, dynamic>>.from(data['records']);
    } catch (e) {
      return [];
    }
  }

  // 온보딩 및 초기 설정
  Future<void> setOnboardingCompleted(bool completed) async {
    await setBool('onboarding_completed', completed);
  }

  Future<bool> isOnboardingCompleted() async {
    return (await getBool('onboarding_completed')) ?? false;
  }

  Future<void> setFirstRun(bool isFirst) async {
    await setBool('first_run', isFirst);
  }

  Future<bool> isFirstRun() async {
    return (await getBool('first_run')) ?? true;
  }
}

// SettingsService - main.dart에서 호출되는 클래스
class SettingsService {
  static final SettingsService instance = SettingsService._internal();
  SettingsService._internal();

  Future<void> loadSettings() async {
    // 실제로는 SettingsBloc에서 설정을 관리하므로 여기서는 빈 구현
    // 필요한 경우 초기 설정 로드 로직을 여기에 추가
  }
}
