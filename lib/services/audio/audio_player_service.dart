import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;
  double _volume = 1.0;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isMuted = prefs.getBool('isMuted') ?? false;
    _volume = prefs.getDouble('volume') ?? 1.0;
    if (_isMuted) {
      _audioPlayer.setVolume(0);
    } else {
      _audioPlayer.setVolume(_volume);
    }
  }

  Future<void> play() async {
    await _audioPlayer.setAsset('assets/audio/optimized/music/music.mp3');
    _audioPlayer.play();
  }

  Future<void> setVolume(double volume) async {
    _volume = volume;
    if (!_isMuted) {
      await _audioPlayer.setVolume(volume);
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('volume', volume);
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    if (_isMuted) {
      await _audioPlayer.setVolume(0);
    } else {
      await _audioPlayer.setVolume(_volume);
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isMuted', _isMuted);
  }
}
