import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._();
  factory AudioManager() => _instance;
  AudioManager._();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;

  Future<void> init() async {
    if (!_isInitialized) {
      await _audioPlayer.setAudioContext(
        AudioContext(
          android: AudioContextAndroid(
            audioFocusGainType: AndroidAudioFocusGainType.gain,
            willPauseWhenDucked: true,
          ),
          iOS: AudioContextIOS(
            defaultHandling: IosCategory.defaultHandling,
          ),
        ),
      );
      _isInitialized = true;
    }
  }

  Future<void> playSound(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
    await _audioPlayer.play();
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  double getVolume() {
    return _audioPlayer.volume ?? 0.0;
  }

  bool get isPlaying => _audioPlayer.playing;

  Future<void> dispose() async {
    await _audioPlayer.dispose();
    _isInitialized = false;
  }
}
