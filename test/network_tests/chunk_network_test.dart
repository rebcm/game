import 'package:test/test.dart';
import 'package:game/network/chunk_network.dart';

void main() {
  test('fetch chunk', () async {
    final url = 'https://example.com/chunk';
    final chunk = await ChunkNetwork.fetchChunk(url);
    expect(chunk, isNotNull);
  });

  test('send chunk', () async {
    final url = 'https://example.com/chunk';
    final data = Uint8List.fromList([1, 2, 3, 4, 5]);
    await ChunkNetwork.sendChunk(url, data);
  });
}
