import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioCacheManager with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void disposeAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
  }

  @override
  void dispose() {
    disposeAudio();
    super.dispose();
  }
}
