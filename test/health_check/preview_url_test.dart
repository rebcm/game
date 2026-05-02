import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  test('Preview URL returns 200', () async {
    final previewUrl = env['PREVIEW_URL'];
    expect(previewUrl, isNotNull);

    final response = await http.get(Uri.parse(previewUrl!));
    expect(response.statusCode, 200);
  });
}
