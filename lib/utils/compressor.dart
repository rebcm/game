import 'dart:typed_data';
import 'package:rebcm/config/config_compressao.dart';

class Compressor {
  static Uint8List comprimir(Uint8List dados) {
    // Implementação da compressão
    // Deve respeitar ConfigCompressao.taxaCompressao e ConfigCompressao.bitrateMinimo
    // Por simplicidade, vamos considerar uma implementação básica
    // que apenas reduz o tamanho dos dados com base na taxa de compressão
    int novoTamanho = (dados.length * ConfigCompressao.taxaCompressao).round();
    return Uint8List.fromList(dados.sublist(0, novoTamanho));
  }
}
