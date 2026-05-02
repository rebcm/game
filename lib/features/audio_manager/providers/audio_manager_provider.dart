import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioManagerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioManagerProvider() {
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setAudioContext(
      AudioContext(
        android: AudioContextAndroid(
          isSpeakerphoneOn: true,
          stayAwake: true,
          contentType: AndroidContentType.music,
        ),
        iOS: AudioContextiOS(
          category: AVAudioSessionCategory.playback,
        ),
      ),
    );
  }

  Future<void> playAudio(String url) async {
    await _audioPlayer.setUrl(url);
    _audioPlayer.play();
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> setPlaylist(List<String> urls) async {
    final playlist = ConcatenatingAudioSource(
      children: urls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
    );
    await _audioPlayer.setAudioSource(playlist);
  }

  Future<void> fadeOut() async {
    await _audioPlayer.setVolume(0);
  }

  Future<void> fadeIn() async {
    await _audioPlayer.setVolume(1);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
