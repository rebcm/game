import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/audio_manager/audio_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioManager()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioManager = Provider.of<AudioManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca Game'),
      ),
      body: Center(
        child: Slider(
          value: audioManager.volume,
          onChanged: (value) => audioManager.setVolume(value),
          min: 0.0,
          max: 1.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => audioManager.playAudio('audio/rebeca_sound.mp3'),
        tooltip: 'Play',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
