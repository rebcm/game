import 'dart:async';
import 'package:flutter/material.dart';

class EstadoJogo extends State {
  Timer? _timer;
  bool _someFlagOrCallbackFired = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Simulate some work
      _someFlagOrCallbackFired = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Getter for testing purposes
  bool get someFlagOrCallbackFired => _someFlagOrCallbackFired;
}
