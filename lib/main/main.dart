import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/audio_manager/playlist_manager.dart';
import 'package:rebcm/audio_manager/music_playlist.dart';

void main() {
  final audioPlayer = AudioPlayer();
  final playlist = [
    'assets/audio/optimized/music/music1.mp3',
    'assets/audio/optimized/music/music2.mp3',
    'assets/audio/optimized/music/music3.mp3',
    'assets/audio/optimized/music/music4.mp3',
  ];

  final playlistManager = PlaylistManager(audioPlayer, playlist);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => playlistManager),
        ChangeNotifierProvider(create: (_) => MusicPlaylist(playlistManager)),
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
                context.read<PlaylistManager>().play();
              },
              child: Text('Play'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PlaylistManager>().next();
              },
              child: Text('Next'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PlaylistManager>().previous();
              },
              child: Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PlaylistManager>().setShuffle(true);
              },
              child: Text('Shuffle'),
            ),
          ],
        ),
      ),
    );
  }
}
