import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/mundo/gerador.dart';

void main() {
  testWidgets('Testa geração de chunks sob estresse', (tester) async {
    for (var i = 0; i < 100; i++) {
      await GeradorMundo.gerarChunk(i, i);
    }
    expect(true, isTrue);
  });
}
