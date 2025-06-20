class Routes {
  // Auth routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  
  // Main app routes
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String leaderboard = '/leaderboard';
  
  // Game routes
  static const String singlePlayer = '/game/single';
  static const String gameMode = '/game/mode';
  static const String gameResult = '/game/result';
  
  // Multiplayer routes
  static const String multiplayerLobby = '/multiplayer/lobby';
  static const String createRoom = '/multiplayer/create';
  static const String joinRoom = '/multiplayer/join';
  static const String gameRoom = '/multiplayer/room';
  
  // Other routes
  static const String achievements = '/achievements';
  static const String tutorial = '/tutorial';
  static const String about = '/about';
}
