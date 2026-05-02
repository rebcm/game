import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio_transition.dart';

class AudioTransitionProvider extends StatelessWidget {
  final Widget child;

  AudioTransitionProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioTransition(),
      child: child,
    );
  }
}
