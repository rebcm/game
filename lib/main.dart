import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/volume_controls/providers/volume_controls_provider.dart';
import 'package:passdriver/features/volume_controls/volume_controls.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VolumeControlsProvider()..init()),
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
        body: VolumeControls(),
      ),
    );
  }
}
