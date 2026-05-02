import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistProvider with ChangeNotifier {
  List<Song> _playlist = [
    Song('song1.mp3', 'Song 1'),
    Song('song2.mp3', 'Song 2'),
    Song('song3.mp3', 'Song 3'),
    Song('song4.mp3', 'Song 4'),
  ];

  LoopMode _loopMode = LoopMode.all;

  List<Song> get playlist => _playlist;
  LoopMode get loopMode => _loopMode;

  void toggleLoopMode() {
    if (_loopMode == LoopMode.all) {
      _loopMode = LoopMode.one;
    } else {
      _loopMode = LoopMode.all;
    }
    notifyListeners();
  }

  void shufflePlaylist() {
    _playlist.shuffle();
    notifyListeners();
  }
}

class Song {
  final String url;
  final String title;

  Song(this.url, this.title);
}
