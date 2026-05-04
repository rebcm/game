import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/cloudflare_service.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('CloudflareService', () {
    late CloudflareService cloudflareService;
    late MockDio dio;

    setUp(() {
      dio = MockDio();
      cloudflareService = CloudflareService();
      cloudflareService._dio = dio;
      dotenv.testEnv = {'CLOUDFLARE_API_TOKEN': 'test_token'};
    });

    test('validateToken returns true when token is valid', () async {
      final response = Response(
        data: {'result': 'valid'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(dio.get(any, options: anyNamed('options'))).thenAnswer((_) async => response);

      final result = await cloudflareService.validateToken();
      expect(result, true);
    });

    test('validateToken returns false when token is invalid', () async {
      final response = Response(
        data: {'result': null},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(dio.get(any, options: anyNamed('options'))).thenAnswer((_) async => response);

      final result = await cloudflareService.validateToken();
      expect(result, false);
    });

    test('validateToken returns false on DioError', () async {
      when(dio.get(any, options: anyNamed('options'))).thenThrow(DioError(requestOptions: RequestOptions(path: '')));

      final result = await cloudflareService.validateToken();
      expect(result, false);
    });
  });
}
