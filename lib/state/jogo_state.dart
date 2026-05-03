import 'dart:async';
import 'package:flutter/material.dart';

class JogoState with WidgetsBindingObserver {
  Timer? _timer;

  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Perform some action
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
