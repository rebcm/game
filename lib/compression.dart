import 'dart:typed_data';
import 'package:archive/archive_io.dart';

Future<Uint8List> compress(Uint8List data) async {
  final encoder = ZLibEncoder();
  return encoder.encode(data);
}
