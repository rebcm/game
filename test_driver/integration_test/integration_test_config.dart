import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:game/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  runApp(app.MyApp(
    renderConfigAppliedKey: const Key('renderConfigApplied'),
    startPerformanceCollectionKey: const Key('startPerformanceCollection'),
  ));
}
