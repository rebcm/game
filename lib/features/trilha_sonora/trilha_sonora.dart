import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class TrilhaSonora extends StatefulWidget {
  @override
  _TrilhaSonoraState createState() => _TrilhaSonoraState();
}

class _TrilhaSonoraState extends State<TrilhaSonora> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.withId('trilha_sonora');
  final List<String> _musicas = [
    'assets/musicas/musica1.mp3',
    'assets/musicas/musica2.mp3',
    'assets/musicas/musica3.mp3',
    'assets/musicas/musica4.mp3',
  ];
  int _indiceMusicaAtual = 0;

  @override
  void initState() {
    super.initState();
    _iniciarReproducao();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  void _iniciarReproducao() {
    _assetsAudioPlayer.open(
      Audio(_musicas[_indiceMusicaAtual]),
      autoStart: true,
      showNotification: false,
    ).then((_) {
      _assetsAudioPlayer.playlistFinished.listen((_) {
        _trocarMusica();
      });
    });
  }

  void _trocarMusica() {
    setState(() {
      _indiceMusicaAtual = (_indiceMusicaAtual + 1) % _musicas.length;
      _assetsAudioPlayer.open(
        Audio(_musicas[_indiceMusicaAtual]),
        autoStart: true,
        transitionMode: TransitionMode.fade(2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Não necessário renderizar nada
  }
}
