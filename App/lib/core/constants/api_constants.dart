class ApiConstants {
  static const String baseUrl = 'http://localhost:8080/api';
  static const String wsUrl = 'ws://localhost:8080/ws';
  
  // Auth endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // User endpoints
  static const String profile = '/user/profile';
  static const String stats = '/user/stats';
  static const String leaderboard = '/user/leaderboard';
  
  // Game endpoints
  static const String gameHistory = '/game/history';
  static const String saveGame = '/game/save';
  
  // Multiplayer endpoints
  static const String createRoom = '/multiplayer/room/create';
  static const String joinRoom = '/multiplayer/room/join';
  static const String leaveRoom = '/multiplayer/room/leave';
  static const String rooms = '/multiplayer/rooms';
  
  // Request timeouts
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  static const Duration sendTimeout = Duration(seconds: 10);
}
