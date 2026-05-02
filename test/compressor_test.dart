import 'package:test/test.dart';
import 'package:rebcm/utils/compressor.dart';
import 'dart:typed_data';

void main() {
  test('Compressor comprimir', () {
    Uint8List dados = Uint8List.fromList([1, 2, 3, 4, 5]);
    Uint8List comprimidos = Compressor.comprimir(dados);
    expect(comprimidos.length, lessThan(dados.length));
  });
}
