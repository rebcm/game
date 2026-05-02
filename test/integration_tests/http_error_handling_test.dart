import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/services/http_service.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HTTP Error Handling Tests', () {
    late http.Client client;
    late HttpService httpService;

    setUp(() {
      client = MockHttpClient();
      httpService = HttpService(client);
    });

    testWidgets('Test 400 Bad Request', (tester) async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));
      final response = await httpService.get('https://example.com/api/resource');
      expect(response.statusCode, 400);
    });

    testWidgets('Test 401 Unauthorized', (tester) async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));
      final response = await httpService.get('https://example.com/api/resource');
      expect(response.statusCode, 401);
    });

    testWidgets('Test 404 Not Found', (tester) async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final response = await httpService.get('https://example.com/api/resource');
      expect(response.statusCode, 404);
    });

    testWidgets('Test 500 Internal Server Error', (tester) async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));
      final response = await httpService.get('https://example.com/api/resource');
      expect(response.statusCode, 500);
    });

    testWidgets('Test Timeout', (tester) async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => Future.delayed(Duration(seconds: 10)));
      expect(() async => await httpService.get('https://example.com/api/resource', timeout: Duration(seconds: 1)),
          throwsA(isA<TimeoutException>()));
    });

    testWidgets('Test Invalid Payload', (tester) async {
      when(() => client.get(Uri.parse('https://example.com/api/resource')))
          .thenAnswer((_) async => http.Response('Invalid JSON', 200));
      expect(() async => await httpService.get('https://example.com/api/resource'),
          throwsA(isA<FormatException>()));
    });
  });
}
