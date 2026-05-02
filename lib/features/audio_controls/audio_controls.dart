import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioControls extends StatefulWidget {
  @override
  _AudioControlsState createState() => _AudioControlsState();
}

class _AudioControlsState extends State<AudioControls> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(_audioPlayer.playing ? Icons.pause : Icons.play_arrow),
          onPressed: () async {
            if (_audioPlayer.playing) {
              await _audioPlayer.pause();
            } else {
              await _audioPlayer.play();
            }
          },
        ),
        Semantics(
          label: 'Volume',
          child: Slider(
            value: _audioPlayer.volume,
            onChanged: (value) {
              _audioPlayer.setVolume(value);
            },
          ),
        ),
      ],
    );
  }
}
