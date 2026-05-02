import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_service.dart';
import 'package:rebcm/game_loop_integration.dart';

void main() {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioServiceImpl _audioService = AudioServiceImpl(_audioPlayer);
  final GameLoopIntegration _gameLoopIntegration = GameLoopIntegration(_audioService);

  runApp(
    MaterialApp(
      home: GameWidget(
        game: _gameLoopIntegration,
      ),
    ),
  );
}
