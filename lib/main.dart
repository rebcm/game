import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AudioService>(create: (_) => AudioService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Voxel World',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioService = Provider.of<AudioService>(context);
    // Example usage
    return Scaffold(
      body: Center(
        child: Slider(
          value: audioService.globalVolume,
          onChanged: (value) => audioService.setGlobalVolume(value),
        ),
      ),
    );
  }
}
