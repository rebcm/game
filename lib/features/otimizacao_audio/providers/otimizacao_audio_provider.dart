import 'package:flutter/material.dart';
import 'package:otimizacao_audio/services/otimizacao_audio_service.dart';

class OtimizacaoAudioProvider with ChangeNotifier {
  final OtimizacaoAudioService _otimizacaoAudioService;

  OtimizacaoAudioProvider(this._otimizacaoAudioService);

  Future<String> otimizarArquivoAudio(String arquivo) async {
    final String caminhoArquivoOtimizado = await _otimizacaoAudioService.otimizarArquivoAudio(arquivo);
    notifyListeners();
    return caminhoArquivoOtimizado;
  }
}
