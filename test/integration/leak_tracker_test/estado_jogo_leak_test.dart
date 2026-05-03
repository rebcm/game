import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  test('EstadoJogo não deve ter memory leaks', () async {
    await LeakTracker.assertNoLeaks(() async {
      final estadoJogo = EstadoJogo();
      await estadoJogo.dispose();
    });
  });
}
