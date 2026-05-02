import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;
  double _volume = 1.0;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isMuted = prefs.getBool('isMuted') ?? false;
    _volume = prefs.getDouble('volume') ?? 1.0;
    if (_isMuted) {
      await _audioPlayer.setVolume(0);
    } else {
      await _audioPlayer.setVolume(_volume);
    }
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMuted', _isMuted);
    if (_isMuted) {
      await _audioPlayer.setVolume(0);
    } else {
      await _audioPlayer.setVolume(_volume);
    }
  }

  Future<void> setVolume(double volume) async {
    _volume = volume;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volume', _volume);
    if (!_isMuted) {
      await _audioPlayer.setVolume(_volume);
    }
  }

  double getVolume() => _volume;
  bool isMuted() => _isMuted;
}
