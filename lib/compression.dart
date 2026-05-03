import 'dart:typed_data';
import 'package:archive/archive.dart';

Uint8List compress(Uint8List data) {
  final encoder = ZLibEncoder();
  return encoder.encode(data);
}
