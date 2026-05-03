import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class PlaylistManager with ChangeNotifier {
  final AudioPlayer _audioPlayer;
  final List<String> _playlist;
  bool _isShuffle = false;
  int _currentIndex = 0;

  PlaylistManager(this._audioPlayer, this._playlist);

  void play() async {
    if (_playlist.isEmpty) return;

    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: _playlist.map((path) => AudioSource.uri(Uri.file(path))).toList(),
        useLazyPreparation: true,
      ),
    );

    if (_isShuffle) {
      _audioPlayer.shuffle();
    }

    _audioPlayer.play();
    notifyListeners();
  }

  void setShuffle(bool shuffle) {
    _isShuffle = shuffle;
    if (_isShuffle) {
      _audioPlayer.shuffle();
    } else {
      _audioPlayer.setShuffleModeEnabled(false);
    }
    notifyListeners();
  }

  void next() {
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
      _audioPlayer.seekToNext();
      notifyListeners();
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _audioPlayer.seekToPrevious();
      notifyListeners();
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
