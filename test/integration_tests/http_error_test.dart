import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/services/http_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late HttpService httpService;

  setUp(() {
    client = MockHttpClient();
    httpService = HttpService(client);
  });

  group('HTTP Error Handling', () {
    test('handles 400 Bad Request', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      final response = await httpService.get('https://example.com/api/resource');
      expect(response.statusCode, 400);
    });

    test('handles 401 Unauthorized', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      final response = await httpService.get('https://example.com/api/resource');
      expect(response.statusCode, 401);
    });

    test('handles 404 Not Found', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final response = await httpService.get('https://example.com/api/resource');
      expect(response.statusCode, 404);
    });

    test('handles 500 Internal Server Error', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      final response = await httpService.get('https://example.com/api/resource');
      expect(response.statusCode, 500);
    });

    test('handles timeout', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => Future.delayed(const Duration(seconds: 10)));

      expect(() async => await httpService.get('https://example.com/api/resource', timeout: const Duration(seconds: 1)),
          throwsA(isA<TimeoutException>()));
    });

    test('handles invalid payload', () async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Invalid JSON', 200));

      expect(() async => await httpService.get('https://example.com/api/resource'),
          throwsA(isA<FormatException>()));
    });
  });
}
