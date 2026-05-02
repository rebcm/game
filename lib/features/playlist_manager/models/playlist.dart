import 'package:flutter/foundation.dart';

class Playlist with ChangeNotifier {
  List<String> _songs = [];
  List<String> get songs => _songs;
  int _currentIndex = 0;
  String get currentSong => _songs[_currentIndex];

  void addSong(String song) {
    _songs.add(song);
    notifyListeners();
  }

  void removeSong(String song) {
    _songs.remove(song);
    if (_currentIndex >= _songs.length) {
      _currentIndex = 0;
    }
    notifyListeners();
  }

  void playNext() {
    _currentIndex = (_currentIndex + 1) % _songs.length;
    notifyListeners();
  }

  void shuffle() {
    _songs = List.from(_songs)..shuffle();
    _currentIndex = 0;
    notifyListeners();
  }
}
