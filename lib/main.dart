import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_player_service.dart';
import 'package:rebcm/widgets/settings/audio_settings.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AudioPlayerService>(create: (_) => AudioPlayerService()),
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
        appBar: AppBar(
          title: Text('Rebeca\'s Game'),
        ),
        body: Center(
          child: AudioSettings(),
        ),
      ),
    );
  }
}
