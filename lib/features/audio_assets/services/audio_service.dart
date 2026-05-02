import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String filename) async {
    final byteData = await rootBundle.load('lib/features/audio_assets/assets/.ogg');
    await _audioPlayer.play(BytesSource(byteData.buffer.asUint8List()));
  }
}
