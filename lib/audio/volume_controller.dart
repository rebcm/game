import 'package:audioplayers/audioplayers.dart';

class VolumeController {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<double> getVolume() async {
    return await _audioPlayer.getVolume();
  }
}
