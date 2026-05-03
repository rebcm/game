import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  runApp(app.MyApp());
}

void coldStart() {
  // Implement cold start logic
}

void cachedLoad() {
  // Implement cached load logic
}
