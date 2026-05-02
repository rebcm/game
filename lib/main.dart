import 'package:flutter/material.dart';
import 'package:rebcm/widgets/mouse_region_wrapper.dart';

void main() {
  await AudioService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebcm Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegionWrapper(
        child: // Your existing widget tree here,
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebcm Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioService _audioService = AudioService();

  Future<void> _playAudio() async {
    await _audioService.playAudio('assets/audio/optimized/music/music.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebcm Game'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _playAudio,
          child: Text('Play Audio'),
        ),
      ),
    );
  }
}
