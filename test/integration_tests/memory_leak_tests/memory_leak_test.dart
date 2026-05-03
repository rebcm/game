import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  test('EstadoJogo should not leak', () async {
    await LeakTracker.assertNoLeaks(
      () async {
        final estadoJogo = EstadoJogo();
        await Future.delayed(Duration(milliseconds: 100));
        estadoJogo.dispose();
      },
      // Optional: You can add more detailed tracking here if needed
    );
  });
}
