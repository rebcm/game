import 'dart:typed_data';
import 'package:rebcm/models/chunk.dart';

class ChunkSerializer {
  Uint8List serialize(Chunk chunk) {
    // Cabeçalho (12 bytes): x (4 bytes), y (4 bytes), z (4 bytes)
    ByteData header = ByteData(12);
    header.setInt32(0, chunk.x, Endian.little);
    header.setInt32(4, chunk.y, Endian.little);
    header.setInt32(8, chunk.z, Endian.little);
    Uint8List headerBytes = header.buffer.asUint8List();

    // Dados dos Blocos
    Uint8List blockData = Uint8List(chunk.blocks.length);
    for (int i = 0; i < chunk.blocks.length; i++) {
      blockData[i] = chunk.blocks[i];
    }

    // Combina cabeçalho e dados dos blocos
    Uint8List serializedData = Uint8List(headerBytes.length + blockData.length);
    serializedData.setRange(0, headerBytes.length, headerBytes);
    serializedData.setRange(headerBytes.length, serializedData.length, blockData);

    return serializedData;
  }

  Chunk deserialize(Uint8List data) {
    // Extrai o cabeçalho
    ByteData header = ByteData.sublistView(data, 0, 12);
    int x = header.getInt32(0, Endian.little);
    int y = header.getInt32(4, Endian.little);
    int z = header.getInt32(8, Endian.little);

    // Extrai os dados dos blocos
    Uint8List blockData = Uint8List.sublistView(data, 12);

    // Cria o chunk
    return Chunk(x: x, y: y, z: z, blocks: blockData);
  }
}
