import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
class AudioTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FlameAudio.play('audio_file.mp3');
          },
          child: Text('Play Audio'));
      ),
    );
  }
}
