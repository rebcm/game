import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/audio/audio_manager.dart';
import 'package:rebcm/audio/volume_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioManager()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: VolumeController(),
      ),
    );
  }
}
