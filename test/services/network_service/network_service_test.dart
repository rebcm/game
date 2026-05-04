import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:game/services/network_service/network_service.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('NetworkService Test', () {
    late Dio dio;
    late NetworkService networkService;

    setUp(() {
      dio = MockDio();
      networkService = NetworkService(dio);
    });

    test('Test checkNetworkConnection with successful response', () async {
      when(dio.get('https://example.com/check_connection')).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: 'https://example.com/check_connection'), statusCode: 200));
      expect(await networkService.checkNetworkConnection(), true);
    });

    test('Test checkNetworkConnection with failed response', () async {
      when(dio.get('https://example.com/check_connection')).thenThrow(DioException(requestOptions: RequestOptions(path: 'https://example.com/check_connection'), error: 'Network error'));
      expect(await networkService.checkNetworkConnection(), false);
    });
  });
}
