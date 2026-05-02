import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/performance/analisador_performance.dart';

class HUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnalisadorPerformance>(
      builder: (context, analisador, child) {
        return Column(
          children: [
            // Outros elementos do HUD
            ElevatedButton(
              onPressed: analisador.toggleRepaintRainbow,
              child: Text(analisador.repaintRainbow ? 'Desativar Repaint Rainbow' : 'Ativar Repaint Rainbow'),
            ),
          ],
        );
      },
    );
  }
}
