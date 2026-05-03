import 'package:audioplayers/audioplayers.dart';

class AudioControlService {
  final AudioPlayer _audioPlayer;

  AudioControlService(this._audioPlayer);

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }
}
