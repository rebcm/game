import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  test('EstadoJogo should not leak', () async {
    await expectLater(
      EstadoJogo(),
      isNotLeaking(
        onLeak: (leak) => throw Exception('Leak detected: $leak'),
      ),
    );
  });
}
