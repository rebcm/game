import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

class MusicPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _playlist = [
    'assets/audio/optimized/music/music1.mp3',
    'assets/audio/optimized/music/music2.mp3',
    'assets/audio/optimized/music/music3.mp3',
    'assets/audio/optimized/music/music4.mp3',
  ];

  List<AudioSource> get _audioSources => _playlist
      .map((path) => AudioSource.uri(Uri.parse(path)))
      .toList();

  ConcatenatingAudioSource get _concatenatingAudioSource =>
      ConcatenatingAudioSource(_audioSources);

  Future<void> init() async {
    await _audioPlayer.setAudioSource(_concatenatingAudioSource);
    _audioPlayer.setLoopMode(LoopMode.all);
    _audioPlayer.setShuffleModeEnabled(true);
    await _audioPlayer.shuffle();
  }

  Future<void> play() async => await _audioPlayer.play();

  Future<void> pause() async => await _audioPlayer.pause();

  Future<void> stop() async => await _audioPlayer.stop();

  Future<void> next() async => await _audioPlayer.seekToNext();

  Future<void> previous() async => await _audioPlayer.seekToPrevious();

  Duration get currentPosition => _audioPlayer.position;

  Duration get duration => _audioPlayer.duration ?? Duration.zero;

  bool get playing => _audioPlayer.playing;
}
