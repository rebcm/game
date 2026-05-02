import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio();
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.setFilePath('assets/audio/test.ogg');
      _audioPlayer.play();
    } catch (e) {
      print('Erro ao reproduzir áudio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _playAudio,
      child: Text('Reproduzir Áudio'),
    );
  }
}
