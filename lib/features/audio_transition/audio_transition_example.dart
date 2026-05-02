import 'package:flutter/material.dart';
import 'package:passdriver/features/audio_transition/widgets/audio_transition_widget.dart';
import 'package:just_audio/just_audio.dart';

class AudioTransitionExample extends StatelessWidget {
  final AudioPlayer _currentPlayer = AudioPlayer();
  final AudioPlayer _nextPlayer = AudioPlayer();

  AudioTransitionExample({Key? key}) : super(key: key) {
    _currentPlayer.setAsset('assets/audio/current_song.mp3');
    _nextPlayer.setAsset('assets/audio/next_song.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transição de Áudio')),
      body: Center(
        child: AudioTransitionWidget(currentPlayer: _currentPlayer, nextPlayer: _nextPlayer),
      ),
    );
  }
}
