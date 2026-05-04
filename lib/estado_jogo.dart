import 'dart:async';
import 'package:flutter/material.dart';

class EstadoJogo extends State {
  List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    // Exemplo de inicialização de um timer
    _timers.add(Timer.periodic(Duration(seconds: 1), (timer) {}));
  }

  @override
  void dispose() {
    for (var timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
    super.dispose();
  }

  bool get hasActiveTimers => _timers.any((timer) => timer.isActive);
}
