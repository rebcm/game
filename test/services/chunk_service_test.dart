import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_service/chunk_service.dart';

void main() {
  group('ChunkService', () {
    test('deve iniciar com chunk 0', () {
      final service = ChunkService();
      expect(service.chunkAtual, 0);
    });

    test('deve mudar o chunk', () {
      final service = ChunkService();
      service.mudarChunk();
      expect(service.chunkAtual, 1);
    });
  });
}
