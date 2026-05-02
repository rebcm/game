import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  test('Cloudflare auth test', () async {
    final token = const String.fromEnvironment('CLOUDFLARE_TOKEN');
    final response = await http.get(
      Uri.parse('https://api.cloudflare.com/client/v4/user/tokens/verify'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    expect(response.statusCode, 200);
  });
}
