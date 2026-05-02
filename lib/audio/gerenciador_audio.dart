import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class GerenciadorAudio {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> inicializar() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.STOP);
  }

  Future<void> tocarMusica(String caminho) async {
    await _audioPlayer.play(AssetSource(caminho), mode: PlayerMode.MEDIA_PLAYER);
  }

  Future<void> pararMusica() async {
    await _audioPlayer.stop();
  }

  Future<void> tocarEfeitoSFX(String caminho) async {
    await _audioPlayer.play(AssetSource(caminho), mode: PlayerMode.LOW_LATENCY);
  }

  Future<void> pararEfeitoSFX() async {
    await _audioPlayer.stop();
  }

  Future<void> ajustarVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }
}
