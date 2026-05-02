import 'dart:typed_data';

class Chunk {
  late Uint8List _data;

  void dispose() {
    _data = Uint8List(0);
  }
}
