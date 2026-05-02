import 'package:flutter/material.dart';
import 'package:passdriver/features/audio_manager/providers/audio_manager_provider.dart';
import 'package:provider/provider.dart';

class AudioManager extends StatelessWidget {
  const AudioManager({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioManagerProvider(),
      child: Consumer<AudioManagerProvider>(
        builder: (context, audioManager, child) {
          return Container(); // implement your UI here
        },
      ),
    );
  }
}
