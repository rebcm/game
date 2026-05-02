import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TrilhaSonora extends StatefulWidget {
  @override
  _TrilhaSonoraState createState() => _TrilhaSonoraState();
}

class _TrilhaSonoraState extends State<TrilhaSonora> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentMusicIndex = 0;
  List<String> _musicList = ['musica1.mp3', 'musica2.mp3', 'musica3.mp3', 'musica4.mp3'];

  @override
  void initState() {
    super.initState();
    _playMusic();
  }

  void _playMusic() {
    _audioPlayer.play('assets/audio/', isLocal: true);
    _audioPlayer.onPlayerCompletion.listen((event) {
      _nextMusic();
    });
  }

  void _nextMusic() {
    _currentMusicIndex = (_currentMusicIndex + 1) % _musicList.length;
    _playMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
