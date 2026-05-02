import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioService _audioService; // Assuming this is how you initialize audio_service

  AudioManager(this._audioService);

  // Existing methods for playing, pausing, etc.

  Future<void> dispose() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    await _audioService.stop(); // Adjust according to actual audio_service usage
  }
}
