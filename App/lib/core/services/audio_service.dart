import 'package:audioplayers/audioplayers.dart';
import '../constants/app_constants.dart';
import 'storage_service.dart';

class AudioService {
  static AudioService? _instance;
  static AudioService get instance => _instance ??= AudioService._();
  
  AudioService._();

  late final AudioPlayer _sfxPlayer;
  late final AudioPlayer _musicPlayer;
  
  bool _initialized = false;
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  double _soundVolume = 0.7;
  double _musicVolume = 0.5;

  Future<void> init() async {
    if (_initialized) return;
    
    _sfxPlayer = AudioPlayer();
    _musicPlayer = AudioPlayer();
    
    // 설정 로드
    await _loadSettings();
    
    // 음악 플레이어 설정
    _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(_musicVolume);
    
    // SFX 플레이어 설정
    await _sfxPlayer.setVolume(_soundVolume);
    
    _initialized = true;
  }

  Future<void> _loadSettings() async {
    final settings = StorageService.instance.getSettings();
    if (settings != null) {
      _soundEnabled = settings.soundEnabled;
      _musicEnabled = settings.musicEnabled;
      _soundVolume = settings.soundVolume;
      _musicVolume = settings.musicVolume;
    }
  }

  // 사운드 효과 재생
  Future<void> playSoundEffect(SoundEffect effect) async {
    if (!_initialized || !_soundEnabled) return;

    try {
      final soundFile = _getSoundFile(effect);
      if (soundFile != null) {
        await _sfxPlayer.play(AssetSource(soundFile));
      }
    } catch (e) {
      print('Sound effect error: $e');
    }
  }

  // 배경음악 재생
  Future<void> playBackgroundMusic() async {
    if (!_initialized || !_musicEnabled) return;

    try {
      if (_musicPlayer.state != PlayerState.playing) {
        await _musicPlayer.play(AssetSource(AppConstants.soundFiles['background']!));
      }
    } catch (e) {
      print('Background music error: $e');
    }
  }

  // 배경음악 정지
  Future<void> stopBackgroundMusic() async {
    if (!_initialized) return;

    try {
      await _musicPlayer.stop();
    } catch (e) {
      print('Stop music error: $e');
    }
  }

  // 배경음악 일시정지
  Future<void> pauseBackgroundMusic() async {
    if (!_initialized) return;

    try {
      await _musicPlayer.pause();
    } catch (e) {
      print('Pause music error: $e');
    }
  }

  // 배경음악 재개
  Future<void> resumeBackgroundMusic() async {
    if (!_initialized || !_musicEnabled) return;

    try {
      await _musicPlayer.resume();
    } catch (e) {
      print('Resume music error: $e');
    }
  }

  // 사운드 설정 업데이트
  Future<void> updateSoundEnabled(bool enabled) async {
    _soundEnabled = enabled;
    if (!enabled) {
      await _sfxPlayer.stop();
    }
  }

  Future<void> updateMusicEnabled(bool enabled) async {
    _musicEnabled = enabled;
    if (enabled) {
      await playBackgroundMusic();
    } else {
      await stopBackgroundMusic();
    }
  }

  Future<void> updateSoundVolume(double volume) async {
    _soundVolume = volume.clamp(0.0, 1.0);
    await _sfxPlayer.setVolume(_soundVolume);
  }

  Future<void> updateMusicVolume(double volume) async {
    _musicVolume = volume.clamp(0.0, 1.0);
    await _musicPlayer.setVolume(_musicVolume);
  }

  // 모든 사운드 정지
  Future<void> stopAllSounds() async {
    if (!_initialized) return;
    
    await _sfxPlayer.stop();
    await _musicPlayer.stop();
  }

  // 게임별 사운드 시퀀스
  Future<void> playGameStartSequence() async {
    await playSoundEffect(SoundEffect.gameStart);
    await Future.delayed(const Duration(milliseconds: 500));
    await playBackgroundMusic();
  }

  Future<void> playGameOverSequence() async {
    await stopBackgroundMusic();
    await playSoundEffect(SoundEffect.gameOver);
  }

  Future<void> playLevelUpSequence() async {
    await playSoundEffect(SoundEffect.levelUp);
  }

  Future<void> playTetrisSequence() async {
    await playSoundEffect(SoundEffect.tetris);
  }

  Future<void> playLineClearSequence(int lines) async {
    if (lines == 4) {
      await playTetrisSequence();
    } else {
      await playSoundEffect(SoundEffect.lineClear);
    }
  }

  // 연속 효과음 (콤보 등)
  Future<void> playComboSound(int comboCount) async {
    // 콤보 수에 따라 피치 조정 (간단한 구현)
    for (int i = 0; i < comboCount.clamp(1, 5); i++) {
      await playSoundEffect(SoundEffect.lineClear);
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  String? _getSoundFile(SoundEffect effect) {
    switch (effect) {
      case SoundEffect.move:
        return AppConstants.soundFiles['move'];
      case SoundEffect.rotate:
        return AppConstants.soundFiles['rotate'];
      case SoundEffect.drop:
        return AppConstants.soundFiles['drop'];
      case SoundEffect.lineClear:
        return AppConstants.soundFiles['lineClear'];
      case SoundEffect.tetris:
        return AppConstants.soundFiles['tetris'];
      case SoundEffect.gameOver:
        return AppConstants.soundFiles['gameOver'];
      case SoundEffect.levelUp:
        return AppConstants.soundFiles['levelUp'];
      case SoundEffect.gameStart:
        return AppConstants.soundFiles['gameStart'] ?? AppConstants.soundFiles['levelUp'];
      case SoundEffect.hold:
        return AppConstants.soundFiles['hold'] ?? AppConstants.soundFiles['rotate'];
      case SoundEffect.lock:
        return AppConstants.soundFiles['lock'] ?? AppConstants.soundFiles['drop'];
      case SoundEffect.warning:
        return AppConstants.soundFiles['warning'] ?? AppConstants.soundFiles['gameOver'];
      case SoundEffect.buttonClick:
        return AppConstants.soundFiles['buttonClick'] ?? AppConstants.soundFiles['move'];
      case SoundEffect.error:
        return AppConstants.soundFiles['error'] ?? AppConstants.soundFiles['warning'];
      case SoundEffect.success:
        return AppConstants.soundFiles['success'] ?? AppConstants.soundFiles['lineClear'];
    }
  }

  // 리소스 해제
  Future<void> dispose() async {
    if (!_initialized) return;
    
    await _sfxPlayer.dispose();
    await _musicPlayer.dispose();
    _initialized = false;
  }

  // Getters
  bool get isInitialized => _initialized;
  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  double get soundVolume => _soundVolume;
  double get musicVolume => _musicVolume;
  bool get isMusicPlaying => _musicPlayer.state == PlayerState.playing;
}

enum SoundEffect {
  move,
  rotate,
  drop,
  lineClear,
  tetris,
  gameOver,
  levelUp,
  gameStart,
  hold,
  lock,
  warning,
  buttonClick,
  error,
  success,
}

// 볼륨 관리 헬퍼 클래스
class VolumeManager {
  static const double _fadeStep = 0.05;
  static const Duration _fadeInterval = Duration(milliseconds: 50);

  static Future<void> fadeOut(AudioPlayer player, {Duration duration = const Duration(seconds: 1)}) async {
    final startVolume = player.volume;
    final steps = (duration.inMilliseconds / _fadeInterval.inMilliseconds).floor();
    final volumeStep = startVolume / steps;

    for (int i = 0; i < steps; i++) {
      final newVolume = (startVolume - (volumeStep * (i + 1))).clamp(0.0, 1.0);
      await player.setVolume(newVolume);
      await Future.delayed(_fadeInterval);
    }

    await player.setVolume(0.0);
  }

  static Future<void> fadeIn(AudioPlayer player, double targetVolume, {Duration duration = const Duration(seconds: 1)}) async {
    await player.setVolume(0.0);
    
    final steps = (duration.inMilliseconds / _fadeInterval.inMilliseconds).floor();
    final volumeStep = targetVolume / steps;

    for (int i = 0; i < steps; i++) {
      final newVolume = (volumeStep * (i + 1)).clamp(0.0, targetVolume);
      await player.setVolume(newVolume);
      await Future.delayed(_fadeInterval);
    }

    await player.setVolume(targetVolume);
  }
}
