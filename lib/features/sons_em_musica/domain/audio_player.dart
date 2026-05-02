import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final SharedPreferences _prefs;

  AudioPlayer(this._prefs);

  Future<void> playMusica(String musica) async {
    await _audioPlayer.play(AssetSource(musica), isLocal: true);
  }

  Future<void> stopMusica() async {
    await _audioPlayer.stop();
  }

  Future<void> playEfeito(String efeito) async {
    await _audioPlayer.play(AssetSource(efeito), isLocal: true);
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<double> getVolume() async {
    return await _audioPlayer.getVolume();
  }

  Future<void> saveVolume() async {
    await _prefs.setDouble('volumeMusica', _audioPlayer.getVolume());
    await _prefs.setDouble('volumeEfeitos', _audioPlayer.getVolume());
  }
}
