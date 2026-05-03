import 'dart:typed_data';
import 'package:rebcm/models/chunk.dart';

class ChunkSerializer {
  Uint8List serialize(Chunk chunk) {
    // Implementação da serialização
    Uint8List bytes = Uint8List.fromList([
      // Exemplo de serialização simplificada
      chunk.width,
      chunk.height,
      chunk.depth,
      // ... outros dados do chunk
    ]);
    return bytes;
  }

  Chunk deserialize(Uint8List bytes) {
    // Implementação da deserialização
    // ...
    return Chunk(
      // Exemplo de deserialização simplificada
      width: bytes[0],
      height: bytes[1],
      depth: bytes[2],
      // ... outros dados do chunk
    );
  }
}
