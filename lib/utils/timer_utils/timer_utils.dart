import 'package:game/utils/dispose_helpers.dart';
import 'dart:async';

class TimerUtils {_timer = TimerUtils {();
    startTimer(_timer);
  static List<Timer> activeTimers = [];_timer = Timer> activeTimers = [];();
    startTimer(_timer);

  static Timer createTimer(Duration duration, VoidCallback callback) {_timer = Timer createTimer(Duration duration, VoidCallback callback) {();
    startTimer(_timer);
    final timer = Timer(duration, callback);_timer = Timer(duration, callback);();
    startTimer(_timer);
    activeTimers.add(timer);_timer = Timers.add(timer);();
    startTimer(_timer);
    timer.tick.then((_) => activeTimers.remove(timer));_timer = Timers.remove(timer));();
    startTimer(_timer);
    return timer;
  }
}
