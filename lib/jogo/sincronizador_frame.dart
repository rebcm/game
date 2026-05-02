import 'package:flame/game.dart';
import 'package:flutter/scheduler.dart';

class SincronizadorFrame with SchedulerBinding {
  late FlameGame _game;
  bool _isFrameScheduled = false;

  void inicializar(FlameGame game) {
    _game = game;
  }

  void sincronizar() {
    if (!_isFrameScheduled) {
      _isFrameScheduled = true;
      scheduleFrameCallback((_) {
        _isFrameScheduled = false;
        _game.update(_.elapsed.toSeconds());
      });
    }
  }
}
