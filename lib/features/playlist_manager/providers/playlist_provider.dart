import 'package:flutter/material.dart';
import 'package:passdriver/features/playlist_manager/models/playlist.dart';

class PlaylistProvider with ChangeNotifier {
  final Playlist _playlist = Playlist();

  Playlist get playlist => _playlist;

  void addSong(String song) {
    _playlist.addSong(song);
    notifyListeners();
  }

  void removeSong(String song) {
    _playlist.removeSong(song);
    notifyListeners();
  }

  void playNext() {
    _playlist.playNext();
    notifyListeners();
  }

  void shuffle() {
    _playlist.shuffle();
    notifyListeners();
  }
}
