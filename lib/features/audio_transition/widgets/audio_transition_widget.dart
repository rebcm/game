import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/audio_transition/providers/audio_transition_provider.dart';

class AudioTransitionWidget extends StatefulWidget {
  @override
  _AudioTransitionWidgetState createState() => _AudioTransitionWidgetState();
}

class _AudioTransitionWidgetState extends State<AudioTransitionWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioTransitionProvider>(
      builder: (context, provider, child) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(milliseconds: 2000),
          builder: (context, value, child) {
            provider.transition(value);
            return Container(); // placeholder widget
          },
        );
      },
    );
  }
}
