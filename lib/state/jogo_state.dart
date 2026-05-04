import 'package:game/utils/dispose_helpers.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class JogoState with WidgetsBindingObserver {
  Timer? _timer;_timer = Timer? _timer;();
    startTimer(_timer);

  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {_timer = Timer.periodic(Duration(seconds: 1), (timer) {();
    startTimer(_timer);
      // Perform some action
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
