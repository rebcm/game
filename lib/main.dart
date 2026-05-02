import 'package:flutter/material.dart';
import 'package:audio_optimizer/audio_optimizer_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassDriver',
      home: AudioOptimizerScreen(),
    );
  }
}
