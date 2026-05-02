import 'package:flutter/material.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  app.main();
}

class StressTest extends StatefulWidget {
  @override
  _StressTestState createState() => _StressTestState();
}

class _StressTestState extends State<StressTest> {
  @override
  Widget build(BuildContext context) {
    return app.MyApp();
  }
}
