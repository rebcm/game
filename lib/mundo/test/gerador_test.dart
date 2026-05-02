import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/mundo/gerador.dart';

void main() {
  test('GeradorMundo generates a chunk', () {
    final chunk = GeradorMundo.gerarChunk(0, 0);
    expect(chunk, isNotNull);
    expect(chunk.blocos.length, greaterThan(0));
  });
}
