import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:game/estado_jogo.dart';

void main() {
  test('EstadoJogo should not leak', () async {
    await expectLater(
      EstadoJogo(),
      isNotLeaking(
        onDispose: () async {
          // Dispose logic if needed
        },
      ),
    );
  });
}
