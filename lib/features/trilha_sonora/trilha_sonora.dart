import Intl.message('package:flutter/material.dart');
import Intl.message('package:audioplayers/audioplayers.dart');

class TrilhaSonora extends StatefulWidget {
  @override
  _TrilhaSonoraState createState() => _TrilhaSonoraState();
}

class _TrilhaSonoraState extends State<TrilhaSonora> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentMusicIndex = 0;
  List<String> _musicList = [Intl.message('musica1.mp3'), Intl.message('musica2.mp3'), Intl.message('musica3.mp3'), Intl.message('musica4.mp3')];

  @override
  void initState() {
    super.initState();
    _playMusic();
  }

  void _playMusic() {
    _audioPlayer.play(Intl.message('assets/audio/'), isLocal: true);
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
