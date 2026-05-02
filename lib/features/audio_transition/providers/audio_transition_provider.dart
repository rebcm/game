import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioTransitionProvider with ChangeNotifier {
  final AudioPlayer _currentPlayer;
  final AudioPlayer _nextPlayer;

  AudioTransitionProvider(this._currentPlayer, this._nextPlayer);

  void _interpolateVolume(double currentVolume, double nextVolume, double t) {
    _currentPlayer.setVolume(currentVolume * (1 - t));
    _nextPlayer.setVolume(nextVolume * t);
  }

  Future<void> transition(double duration) async {
    final currentVolume = _currentPlayer.volume ?? 1.0;
    final nextVolume = _nextPlayer.volume ?? 1.0;

    await _nextPlayer.play();
    await _nextPlayer.seek(Duration.zero);

    final startTime = DateTime.now().millisecondsSinceEpoch;
    final endTime = startTime + (duration * 1000).toInt();

    while (DateTime.now().millisecondsSinceEpoch < endTime) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final t = (now - startTime) / (endTime - startTime);
      _interpolateVolume(currentVolume, nextVolume, t);
      await Future.delayed(const Duration(milliseconds: 16)); // ~60 FPS
    }

    _interpolateVolume(currentVolume, nextVolume, 1.0);
    await _currentPlayer.stop();
    notifyListeners();
  }
}
