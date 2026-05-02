import 'package:flutter/material.dart';
import 'package:rebcm/audio/gerenciador_audio.dart';

class HUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Lógica de UI existente
      child: ElevatedButton(
        onPressed: () async {
          await GerenciadorAudio.tocarAudio('assets/audio/optimized/sfx/button_click.mp3');
        },
        child: Text('Clique aqui'),
      ),
    );
  }
}
