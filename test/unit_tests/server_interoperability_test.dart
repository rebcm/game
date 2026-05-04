import 'package:test/test.dart';
import 'package:dio/dio.dart';

void main() {
  test('Validate server interoperability', () async {
    final dio = Dio();
    final response = await dio.get('https://example.com/api/endpoint');
    expect(response.statusCode, 200);
  });
}
