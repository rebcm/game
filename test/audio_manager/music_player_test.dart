import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/audio_manager/music_player.dart';

void main() {
  group('MusicPlayer', () {
    late MusicPlayer musicPlayer;

    setUp(() {
      musicPlayer = MusicPlayer();
    });

    test('initial state', () {
      expect(musicPlayer._isPlaying, false);
      expect(musicPlayer._isShuffle, false);
    });

    test('play and pause', () async {
      musicPlayer.play();
      await Future.delayed(Duration(seconds: 1));
      expect(musicPlayer._isPlaying, true);
      musicPlayer.pause();
      await Future.delayed(Duration(seconds: 1));
      expect(musicPlayer._isPlaying, false);
    });

    test('toggle shuffle', () {
      expect(musicPlayer._isShuffle, false);
      musicPlayer.toggleShuffle();
      expect(musicPlayer._isShuffle, true);
      musicPlayer.toggleShuffle();
      expect(musicPlayer._isShuffle, false);
    });
  });
}
