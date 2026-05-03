import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/services/audio_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voxel Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioService = Provider.of<AudioService>(context);
    return Scaffold(
      body: Center(
        child: Text(audioService.isConnected ? 'Audio playing' : 'Audio paused'),
      ),
    );
  }
}
