import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/music_player.dart';

class RebcmApp extends StatefulWidget {
  @override
  _RebcmAppState createState() => _RebcmAppState();
}

class _RebcmAppState extends State<RebcmApp> {
  final MusicPlayer _musicPlayer = MusicPlayer();

  @override
  void initState() {
    super.initState();
    _musicPlayer.init();
  }

  @override
  void dispose() {
    _musicPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebcm',
      home: Scaffold(
        body: Center(
          child: Text('Rebcm App'),
        ),
      ),
    );
  }
}
