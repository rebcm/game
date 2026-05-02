import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

/// Gerencia a reprodução de áudio no jogo.
///
/// Responsável por carregar e tocar sons, músicas e efeitos sonoros.
class GerenciadorAudio {
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// Carrega um arquivo de áudio.
  Future<void> carregarAudio(String caminho) async {
    await _audioPlayer.setSource(AssetSource(caminho));
  }

  /// Toca um som ou música.
  Future<void> tocarAudio(String caminho) async {
    await carregarAudio(caminho);
    await _audioPlayer.resume();
  }

  /// Pausa a reprodução de áudio.
  Future<void> pausarAudio() async {
    await _audioPlayer.pause();
  }

  /// Para a reprodução de áudio.
  Future<void> pararAudio() async {
    await _audioPlayer.stop();
  }

  /// Libera recursos do player de áudio.
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
