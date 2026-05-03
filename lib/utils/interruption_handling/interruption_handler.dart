import 'package:flutter/material.dart';

class InterruptionHandler with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Handle app pause
    } else if (state == AppLifecycleState.resumed) {
      // Handle app resume
    }
  }
}
