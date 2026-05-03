import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await _audioPlayer.play('audio/sample.mp3');
            setState(() {
              _isPlaying = true;
            });
          },
          child: Text('Play Audio'),
        ),
        ElevatedButton(
          onPressed: () async {
            await _audioPlayer.stop();
            setState(() {
              _isPlaying = false;
            });
          },
          child: Text('Stop Audio'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Simulate audio interruption
            await _audioPlayer.stop();
            setState(() {
              _isPlaying = false;
            });
          },
          tooltip: 'Interrupt Audio',
          child: Text('Interrupt Audio'),
        ),
        Text(
          _isPlaying ? 'Playing' : 'Stopped',
          tooltip: 'Audio Status',
        ),
      ],
    );
  }
}
