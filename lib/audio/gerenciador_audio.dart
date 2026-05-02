import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class GerenciadorAudio {
  static final GerenciadorAudio _instance = GerenciadorAudio._();
  factory GerenciadorAudio() => _instance;
  GerenciadorAudio._();

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> carregarAudio(String path) async {
    await _audioPlayer.setSource(AssetSource(path));
  }

  Future<void> tocarAudio() async {
    await _audioPlayer.resume();
  }

  Future<void> pararAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> liberarRecursos() async {
    await _audioPlayer.dispose();
  }
}
