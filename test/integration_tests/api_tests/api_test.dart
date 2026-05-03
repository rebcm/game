import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('API endpoints test', (tester) async {
    final blocksResponse = await http.get(Uri.parse('http://localhost:8080/api/blocks'));
    expect(blocksResponse.statusCode, 200);

    final biomeResponse = await http.get(Uri.parse('http://localhost:8080/api/biome'));
    expect(biomeResponse.statusCode, 200);
  });
}
