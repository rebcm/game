import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/playlist_manager/providers/playlist_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaylistManager extends StatefulWidget {
  @override
  _PlaylistManagerState createState() => _PlaylistManagerState();
}

class _PlaylistManagerState extends State<PlaylistManager> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playCurrentSong();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playCurrentSong() async {
    final playlist = context.read<PlaylistProvider>().playlist;
    await _audioPlayer.play(UrlSource(playlist.currentSong));
  }

  @override
  Widget build(BuildContext context) {
    final playlist = context.watch<PlaylistProvider>().playlist;

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<PlaylistProvider>().playNext();
            _playCurrentSong();
          },
          child: Text('Tocar próxima'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<PlaylistProvider>().shuffle();
            _playCurrentSong();
          },
          child: Text('Embaralhar'),
        ),
      ],
    );
  }
}
