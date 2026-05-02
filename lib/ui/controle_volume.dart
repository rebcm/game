import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/audio/gerenciador_audio.dart';

class ControleVolume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gerenciadorAudio = context.watch<GerenciadorAudio>();

    return Row(
      children: [
        IconButton(
          icon: Icon(gerenciadorAudio.muted ? Icons.volume_off : Icons.volume_up),
          onPressed: () async {
            await gerenciadorAudio.toggleMute();
          },
        ),
        Expanded(
          child: Slider(
            value: gerenciadorAudio.volume,
            min: 0,
            max: 1,
            divisions: 10,
            label: '${(gerenciadorAudio.volume * 100).round()}%',
            onChanged: (value) async {
              await gerenciadorAudio.setVolume(value);
            },
          ),
        ),
      ],
    );
  }
}
