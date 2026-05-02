import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/preferences/preference_service.dart';

class AudioManager {
  final AudioPlayer _audioPlayer;
  final PreferenceService _preferenceService;

  AudioManager(this._audioPlayer, this._preferenceService);

  Future<void> init() async {
    final volume = await _preferenceService.getVolume();
    await _audioPlayer.setVolume(volume);
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
    await _preferenceService.setVolume(volume);
  }
}
