import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_transition_provider.dart';

class AudioTransition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioTransitionProvider = context.watch<AudioTransitionProvider>();
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: audioTransitionProvider.beginVolume, end: audioTransitionProvider.endVolume),
      duration: Duration(milliseconds: audioTransitionProvider.transitionDuration),
      builder: (context, volume, child) {
        audioTransitionProvider.setCurrentVolume(volume);
        return child;
      },
      child: audioTransitionProvider.currentAudioWidget,
    );
  }
}
