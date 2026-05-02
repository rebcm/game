import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioManager with ChangeNotifier {
  static AudioManager? _instance;

  factory AudioManager() => _instance ??= AudioManager._();

  AudioManager._() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);
  }

  late AudioPlayer _audioPlayer;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  double _volume = 1.0;
  double get volume => _volume;

  String? _currentTrack;
  String? get currentTrack => _currentTrack;

  void play(String track) async {
    if (_currentTrack != track) {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(track));
      _currentTrack = track;
      _isPlaying = true;
      notifyListeners();
    } else if (!_isPlaying) {
      await _audioPlayer.resume();
      _isPlaying = true;
      notifyListeners();
    }
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentTrack = null;
    notifyListeners();
  }

  void setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
    _volume = volume;
    notifyListeners();
  }
}
