import 'package:flutter/material.dart';
import 'package:rebcm/audio_manager/playlist_manager.dart';

class MusicPlaylist with ChangeNotifier {
  static const List<String> _musicPaths = [
    'assets/audio/optimized/music/music1.mp3',
    'assets/audio/optimized/music/music2.mp3',
    'assets/audio/optimized/music/music3.mp3',
    'assets/audio/optimized/music/music4.mp3',
  ];

  final PlaylistManager _playlistManager;

  MusicPlaylist(this._playlistManager) {
    _playlistManager.setShuffle(false);
  }

  void init() {
    _playlistManager.play();
  }
}
