import 'package:rebcm/services/audio_manager/audio_manager.dart';

class AudioManagerSingleton {
  static final AudioManager _audioManager = AudioManager();

  static AudioManager get instance => _audioManager;

  static void dispose() {
    _audioManager.dispose();
  }
}
