import 'dart:io';
import 'dart:typed_data';

class ChunkService {
  static Future<bool> validateChunkFile(File file) async {
    final bytes = await file.readAsBytes();
    final magicNumber = bytes.sublist(0, 4);
    final version = bytes.sublist(4, 8);

    // implement actual validation logic here
    // for demonstration purposes, assume magic number is 'REBC' and version is 1
    return magicNumber == Uint8List.fromList([82, 69, 66, 67]) && version == Uint8List.fromList([0, 0, 0, 1]);
  }
}
