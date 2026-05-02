import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:passdriver/features/playlist_manager/providers/playlist_provider.dart';
import 'package:provider/provider.dart';

class PlaylistManager extends StatefulWidget {
  @override
  _PlaylistManagerState createState() => _PlaylistManagerState();
}

class _PlaylistManagerState extends State<PlaylistManager> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    final playlist = context.read<PlaylistProvider>().playlist;
    await _audioPlayer.setAudioSource(ConcatenatingAudioSource(
      children: playlist.map((song) => AudioSource.uri(Uri.parse(song.url))).toList(),
    ));
    _audioPlayer.setLoopMode(context.read<PlaylistProvider>().loopMode);
    _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, playlistProvider, child) {
        return AudioPlayerWidget(audioPlayer: _audioPlayer);
      },
    );
  }
}
