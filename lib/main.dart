import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/audio_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AudioServiceImpl _audioService = AudioServiceImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s World',
      home: MyHomePage(audioService: _audioService),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final AudioServiceImpl audioService;

  MyHomePage({required this.audioService});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await widget.audioService.playSound('place_block.mp3');
              },
              child: Text('Place Block'),
            ),
            ElevatedButton(
              onPressed: () async {
                await widget.audioService.playSound('break_block.mp3');
              },
              child: Text('Break Block'),
            ),
            ElevatedButton(
              onPressed: () async {
                await widget.audioService.playSound('jump.mp3');
              },
              child: Text('Jump'),
            ),
            ElevatedButton(
              onPressed: () async {
                await widget.audioService.playSound('fly.mp3');
              },
              child: Text('Fly'),
            ),
            ElevatedButton(
              onPressed: () async {
                await widget.audioService.playSound('inventory_open.mp3');
              },
              child: Text('Open Inventory'),
            ),
            ElevatedButton(
              onPressed: () async {
                await widget.audioService.playAmbient('ambient.mp3');
              },
              child: Text('Play Ambient'),
            ),
          ],
        ),
      ),
    );
  }
}
