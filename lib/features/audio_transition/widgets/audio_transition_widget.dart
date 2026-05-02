import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/audio_transition/providers/audio_transition_provider.dart';

class AudioTransitionWidget extends StatelessWidget {
  final AudioPlayer currentPlayer;
  final AudioPlayer nextPlayer;

  const AudioTransitionWidget({Key? key, required this.currentPlayer, required this.nextPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioTransitionProvider(currentPlayer, nextPlayer),
      child: Consumer<AudioTransitionProvider>(
        builder: (context, provider, child) {
          return ElevatedButton(
            onPressed: () async {
              await provider.transition(3.0); // 3 seconds transition
            },
            child: const Text('Transição Suave'),
          );
        },
      ),
    );
  }
}
