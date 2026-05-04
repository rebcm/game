import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:archive/archive.dart';

class PayloadSpecification {
  static const int magicNumber = 0x12345678;

  static Uint8List serialize(Object data) {
    // Implementação da serialização
  }

  static Object deserialize(Uint8List bytes) {
    // Implementação da deserialização
  }

  static int calculateChecksum(Uint8List bytes) {
    return crc32(bytes);
  }
}
