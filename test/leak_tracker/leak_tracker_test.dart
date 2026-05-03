import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  test('EstadoJogo should be garbage collected', () async {
    await expectLater(
      EstadoJogo(),
      isNotLeaked(),
    );
  });
}
