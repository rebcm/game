import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

class MusicPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _playlist = [
    'assets/audio/optimized/music/placeholder_music1.mp3',
    'assets/audio/optimized/music/placeholder_music2.mp3',
    'assets/audio/optimized/music/placeholder_music3.mp3',
    'assets/audio/optimized/music/placeholder_music.mp3',
  ];

  Future<void> init() async {
    await _audioPlayer.setLoopMode(LoopMode.one);
    await _shufflePlaylist();
    await _play();
  }

  Future<void> _shufflePlaylist() async {
    final shuffled = [..._playlist]..shuffle();
    await _audioPlayer.setAsset(shuffled.first);
    await _audioPlayer.setLoopMode(LoopMode.one);
    _audioPlayer.playing
        ? await _audioPlayer.stop()
        : await _audioPlayer.setAsset(shuffled.first);
    await _audioPlayer.play();
    for (var i = 1; i < shuffled.length; i++) {
      await _audioPlayer.setAsset(shuffled[i]);
      await _audioPlayer.play();
      await Future.delayed(Duration(milliseconds: _audioPlayer.duration!.inMilliseconds));
    }
  }

  Future<void> _play() async {
    await _audioPlayer.play();
  }

  Future<void> playSequential() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
      children: _playlist.map((path) => AudioSource.asset(path)).toList(),
    );
    await _audioPlayer.setAudioSource(playlist);
    await _play();
  }

  Future<void> playShuffle() async {
    await _shufflePlaylist();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Duration? getCurrentPosition() {
    return _audioPlayer.position;
  }

  Duration? getDuration() {
    return _audioPlayer.duration;
  }

  bool get playing => _audioPlayer.playing;
}
