import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/services/chunk/chunk_service.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ChunkService integration test', (tester) async {
    final httpClient = http.Client();
    final chunkService = ChunkService(httpClient);
    final chunk = await chunkService.fetchChunk('chunk1');
    expect(chunk, isNotNull);
  });
}
