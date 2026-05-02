import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/audio/audio_manager.dart';

class AudioExampleUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioManager = Provider.of<AudioManager>(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await audioManager.play('assets/audio/optimized/music/example.mp3');
          },
          child: Text('Play Music'),
        ),
        ElevatedButton(
          onPressed: () async {
            await audioManager.pause();
          },
          child: Text('Pause'),
        ),
        ElevatedButton(
          onPressed: () async {
            await audioManager.stop();
          },
          child: Text('Stop'),
        ),
        ElevatedButton(
          onPressed: () async {
            await audioManager.fadeIn();
          },
          child: Text('Fade In'),
        ),
        ElevatedButton(
          onPressed: () async {
            await audioManager.fadeOut();
          },
          child: Text('Fade Out'),
        ),
      ],
    );
  }
}
