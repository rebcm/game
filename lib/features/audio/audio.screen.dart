import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio.feature.dart';

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioFeature _audioFeature = AudioFeature(_audioPlayer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _audioFeature.playAudio('https://example.com/audio.mp3');
              },
              child: Text('Play Audio'),
            ),
            ElevatedButton(
              onPressed: () {
                _audioFeature.pauseAudio();
              },
              child: Text('Pause Audio'),
            ),
            ElevatedButton(
              onPressed: () {
                _audioFeature.stopAudio();
              },
              child: Text('Stop Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
