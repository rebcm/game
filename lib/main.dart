import 'package:flutter/material.dart';
import 'package:rebcm/services/audio_manager/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final audioManager = AudioManager();
  await audioManager.init();

  runApp(MyApp(audioManager: audioManager));
}

class MyApp extends StatelessWidget {
  final AudioManager _audioManager;

  const MyApp({Key? key, required AudioManager audioManager})
      : _audioManager = audioManager,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(audioManager: _audioManager),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final AudioManager _audioManager;

  const MyHomePage({Key? key, required AudioManager audioManager})
      : _audioManager = audioManager,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _audioManager.playSound('assets/audio/optimized/test.mp3');
              },
              child: Text('Play Sound'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _audioManager.stopSound();
              },
              child: Text('Stop Sound'),
            ),
          ],
        ),
      ),
    );
  }
}
