import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/audio_service.dart';
import 'package:rebcm/services/audio/sound_effects_manager.dart';
import 'package:rebcm/game_logic.dart';

void main() {
  final AudioService audioService = AudioService();
  final SoundEffectsManager soundEffectsManager = SoundEffectsManager(audioService);
  final GameLogic gameLogic = GameLogic(soundEffectsManager);

  runApp(MyApp(gameLogic: gameLogic));
}

class MyApp extends StatelessWidget {
  final GameLogic gameLogic;

  const MyApp({Key? key, required this.gameLogic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Existing app widget tree
  }
}
