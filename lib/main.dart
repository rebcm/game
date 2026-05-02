import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/audio_transition/providers/audio_transition_provider.dart';
import 'package:passdriver/features/audio_transition/widgets/audio_transition_widget.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  final currentPlayer = AudioPlayer();
  final nextPlayer = AudioPlayer();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AudioTransitionProvider(
            currentPlayer: currentPlayer,
            nextPlayer: nextPlayer,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    builder: (context, child) => ...addAudioControlRoute(...),
      home: Scaffold(
        body: AudioTransitionWidget(),
      ),
    );
  }
}
