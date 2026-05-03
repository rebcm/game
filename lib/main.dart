import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/audio_manager/music_player.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicPlayer()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s World',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicPlayer = Provider.of<MusicPlayer>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s World'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                musicPlayer.play();
              },
              child: Text('Play'),
            ),
            ElevatedButton(
              onPressed: () {
                musicPlayer.pause();
              },
              child: Text('Pause'),
            ),
            ElevatedButton(
              onPressed: () {
                musicPlayer.toggleShuffle();
              },
              child: Text('Toggle Shuffle'),
            ),
          ],
        ),
      ),
    );
  }
}
