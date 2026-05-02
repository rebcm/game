import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/playlist_manager/models/playlist.dart';

void main() {
  group('Playlist', () {
    test('adds song to playlist', () {
      final playlist = Playlist();
      playlist.addSong('song1.mp3');
      expect(playlist.songs, ['song1.mp3']);
    });

    test('removes song from playlist', () {
      final playlist = Playlist();
      playlist.addSong('song1.mp3');
      playlist.removeSong('song1.mp3');
      expect(playlist.songs, []);
    });

    test('plays next song', () {
      final playlist = Playlist();
      playlist.addSong('song1.mp3');
      playlist.addSong('song2.mp3');
      playlist.playNext();
      expect(playlist.currentSong, 'song2.mp3');
    });

    test('shuffles playlist', () {
      final playlist = Playlist();
      playlist.addSong('song1.mp3');
      playlist.addSong('song2.mp3');
      playlist.shuffle();
      expect(playlist.songs.length, 2);
    });
  });
}
