import 'package:flutter/material.dart';

class AudioManager {
  static AudioManager? _instance;
  bool _isPlaying = false;

  static AudioManager get instance => _instance ??= AudioManager._();

  AudioManager._();

  bool get isPlaying => _isPlaying;

  Future<void> playAudio(String audioPath) async {
    _isPlaying = true;
  }

  Future<void> pauseAudio() async {
    _isPlaying = false;
  }

  Future<void> resumeAudio() async {
    _isPlaying = true;
  }
}
