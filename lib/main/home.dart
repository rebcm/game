import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/providers/music_provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s World'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: musicProvider.playSequential,
              child: Text('Play Sequential'),
            ),
            ElevatedButton(
              onPressed: musicProvider.playShuffle,
              child: Text('Play Shuffle'),
            ),
            ElevatedButton(
              onPressed: musicProvider.pause,
              child: Text('Pause'),
            ),
            ElevatedButton(
              onPressed: musicProvider.stop,
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
