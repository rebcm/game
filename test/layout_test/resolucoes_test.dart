import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rebcm/game.dart';

void main() {
  group('Layout de Dicas', () {
    testGoldens('deve exibir corretamente em diferentes resoluções', (tester) async {
      final deviceSizes = [
        const Size(320, 480), // Resolução mínima
        const Size(360, 640), // Dispositivo alvo
        const Size(414, 896), // iPhone XR
      ];

      for (var size in deviceSizes) {
        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..overrideSurfaceSize(size)
            ..addScenario(
              widget: DicasWidget(), // Supondo que DicasWidget é o widget a ser testado
              name: 'Dicas em ${size.width}x${size.height}',
            ),
        );

        await screenMatchesGolden(tester, 'dicas_${size.width}x${size.height}');
      }
    });
  });
}
