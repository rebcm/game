import 'package:audioplayers/audioplayers.dart';
import 'package:rebcm/audio/otimizador_audio.dart';

class GerenciadorAudio {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> inicializar() async {
    await OtimizadorAudio.otimizarAudio();
  }

  static Future<void> tocarAudio(String caminhoAudio) async {
    await _audioPlayer.play(AssetSource(caminhoAudio));
  }
}
