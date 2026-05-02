import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:passdriver/features/audio_transition/providers/audio_transition_provider.dart';
import 'package:passdriver/features/audio_transition/widgets/audio_transition_widget.dart';

void main() {
  await dotenv.initialize();
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => BuildConfig()),], child: MyApp()));
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
      home: Scaffold(
        body: AudioTransitionWidget(),
      ),
    );
  }
}
import 'features/audio_transition/audio_transition_provider.dart';
import 'features/music_player/music_player_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AudioTransitionProvider(
      child: MusicPlayerProvider(
        child: MaterialApp(
          // restante do código
        ),
      ),
    );
  }
}
