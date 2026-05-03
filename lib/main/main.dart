import 'package:flutter/material.dart';
import 'package:game/widgets/audio_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Recovery Test',
      home: Scaffold(
        body: Center(
          child: AudioPlayerWidget(),
        ),
      ),
    );
  }
}
