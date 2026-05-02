import 'package:rebcm/audio/otimizador_audio.dart';

class GerenciadorAudio {
  static final Map<String, bool> _audiosCarregados = {};

  static Future<void> carregarAudio(String assetPath) async {
    if (!_audiosCarregados.containsKey(assetPath)) {
      await OtimizadorAudio.preloadAudio(assetPath);
      _audiosCarregados[assetPath] = true;
    }
  }

  static Future<void> tocarAudio(String assetPath) async {
    await carregarAudio(assetPath);
    await OtimizadorAudio.playAudio(assetPath);
  }

  static Future<void> pararAudio() async {
    await OtimizadorAudio.stopAudio();
  }

  static Future<void> liberarRecursos() async {
    await OtimizadorAudio.releaseResources();
  }
}
