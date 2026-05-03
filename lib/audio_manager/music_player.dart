import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<String> _playlist = [
    'assets/audio/optimized/music/music1.mp3',
    'assets/audio/optimized/music/music2.mp3',
    'assets/audio/optimized/music/music3.mp3',
    'assets/audio/optimized/music/music4.mp3',
  ];
  int _currentIndex = 0;
  bool _isShuffle = false;
  bool _isPlaying = false;

  MusicPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _playNext();
      }
    });
  }

  void _playNext() {
    if (_isShuffle) {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
      _currentIndex = _getRandomIndex();
    } else {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
    }
    _playCurrent();
  }

  int _getRandomIndex() {
    return (_currentIndex + (DateTime.now().millisecondsSinceEpoch % (_playlist.length - 1))) % _playlist.length;
  }

  void _playCurrent() {
    _audioPlayer.setFilePath(_playlist[_currentIndex]);
    _audioPlayer.play();
  }

  void play() {
    if (!_isPlaying) {
      _playCurrent();
      _isPlaying = true;
    }
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
