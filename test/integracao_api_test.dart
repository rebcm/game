import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/services/api_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('API Service', () {
    late http.Client client;
    late ApiService apiService;

    setUp(() {
      client = MockHttpClient();
      apiService = ApiService(client);
    });

    test('401 Unauthorized', () async {
      when(() => client.get(Uri.parse('https://example.com/api/data'))).thenAnswer((_) async => http.Response('Unauthorized', 401));
      expect(() async => await apiService.fetchData(), throwsException);
    });

    test('404 Not Found', () async {
      when(() => client.get(Uri.parse('https://example.com/api/data'))).thenAnswer((_) async => http.Response('Not Found', 404));
      expect(() async => await apiService.fetchData(), throwsException);
    });

    test('500 Internal Server Error', () async {
      when(() => client.get(Uri.parse('https://example.com/api/data'))).thenAnswer((_) async => http.Response('Internal Server Error', 500));
      expect(() async => await apiService.fetchData(), throwsException);
    });

    test('Conexão instável', () async {
      when(() => client.get(Uri.parse('https://example.com/api/data'))).thenThrow(SocketException('Conexão instável'));
      expect(() async => await apiService.fetchData(), throwsException);
    });
  });
}
