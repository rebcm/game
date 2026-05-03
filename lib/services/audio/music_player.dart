import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

class MusicPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _playlist = [
    'assets/audio/optimized/music/placeholder_music1.mp3',
    'assets/audio/optimized/music/placeholder_music2.mp3',
    'assets/audio/optimized/music/placeholder_music3.mp3',
  ];

  Future<void> init() async {
    await _audioPlayer.setLoopMode(LoopMode.one);
    await _shufflePlaylist();
    await _play();
  }

  Future<void> _shufflePlaylist() async {
    _playlist.shuffle();
    await _audioPlayer.setAsset(_playlist.first);
    for (var i = 1; i < _playlist.length; i++) {
      await _audioPlayer.concat([AudioSource.uri(Uri.parse(_playlist[i]))]);
    }
  }

  Future<void> _play() async {
    await _audioPlayer.play();
  }

  Future<void> playNext() async {
    await _audioPlayer.seekToNext();
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
