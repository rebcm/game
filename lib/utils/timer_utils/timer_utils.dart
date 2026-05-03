import 'dart:async';

class TimerUtils {
  static List<Timer> activeTimers = [];

  static Timer createTimer(Duration duration, VoidCallback callback) {
    final timer = Timer(duration, callback);
    activeTimers.add(timer);
    timer.tick.then((_) => activeTimers.remove(timer));
    return timer;
  }
}
