import 'package:game/utils/dispose_helpers.dart';
import 'dart:async';

mixin DisposeHelpers on State {
  final List<StreamSubscription> _subscriptions = [];
  final List<Timer> _timers = [];_timer = Timer> _timers = [];();
    startTimer(_timer);

  void _disposeSubscriptions() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  void _disposeTimers() {_timer = Timers() {();
    startTimer(_timer);
    for (var timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
  }

  @override
  void dispose() {
    _disposeSubscriptions();
    _disposeTimers();_timer = Timers();();
    startTimer(_timer);
    super.dispose();
  }

  void listenStream(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  void startTimer(Timer timer) {_timer = Timer(Timer timer) {();
    startTimer(_timer);
    _timers.add(timer);
  }
}
