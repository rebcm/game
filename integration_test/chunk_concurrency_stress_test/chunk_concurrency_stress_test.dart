import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/chunk_manager.dart';
import 'package:game/chunk.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Chunk Concurrency Stress Test', () {
    testWidgets('Multiple simultaneous chunk uploads', (tester) async {
      final chunkManager = ChunkManager();
      final chunk = Chunk(id: 'test_chunk', data: List.generate(1024, (index) => index));

      await Future.wait(List.generate(10, (index) => chunkManager.uploadChunk(chunk)));

      expect(await chunkManager.getChunk('test_chunk'), chunk.data);
    });

    testWidgets('Concurrent chunk uploads with overlapping data', (tester) async {
      final chunkManager = ChunkManager();
      final chunk = Chunk(id: 'test_chunk', data: List.generate(1024, (index) => index));

      await Future.wait(List.generate(5, (index) => chunkManager.uploadChunk(chunk)));

      expect(await chunkManager.getChunk('test_chunk'), chunk.data);
    });
  });
}
