import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'music_player.dart';
import '../audio_transition/audio_transition.dart';

class MusicPlayerProvider extends StatelessWidget {
  final Widget child;

  MusicPlayerProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    final audioTransition = Provider.of<AudioTransition>(context);
    return ChangeNotifierProvider(
      create: (_) => MusicPlayer(audioTransition),
      child: child,
    );
  }
}
