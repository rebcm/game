import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String assetPath) async {
    await _audioPlayer.play(AssetSource(assetPath));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> setOutput(Device device) async {
    // Implement logic to set output device
  }

  Future<Device> getOutput() async {
    // Implement logic to get current output device
    return Device.Speaker; // Placeholder
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<double> getVolume() async {
    return await _audioPlayer.getVolume();
  }
}

enum Device { Speaker, Headphones }
