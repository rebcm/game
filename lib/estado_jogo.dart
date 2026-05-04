import 'dart:async';

class EstadoJogo {
  List<Timer> _timers = [];

  void iniciarTimers() {
    _timers.add(Timer.periodic(Duration(seconds: 1), (timer) {}));
  }

  bool temTimersAtivos() {
    return _timers.any((timer) => timer.isActive);
  }

  void dispose() {
    for (var timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
  }
}
