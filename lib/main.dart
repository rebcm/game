import 'package:flutter/material.dart';
import 'package:rebcm/widgets/mouse_region_widget.dart';

void main() {
  final AudioManager _audioManager = AudioManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _audioManager.playMusic(assets/audio/optimized/music/main_theme.mp3);
    return MaterialApp(
      home: Scaffold(
        body: MouseRegionWidget(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
