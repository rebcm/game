import 'package:flutter/material.dart';

class AppLifecycleTestingUtils {
  static void simulatePause(WidgetTester tester) {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
  }

  static void simulateResume(WidgetTester tester) {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
  }

  static void simulateInactive(WidgetTester tester) {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
  }

  static void simulateDetached(WidgetTester tester) {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.detached);
  }
}
