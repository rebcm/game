import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('ApiService', () {
    late ApiService apiService;
    late MockDio dio;

    setUp(() {
      dio = MockDio();
      apiService = ApiService(dio);
    });

    test('get', () async {
      when(dio.get(any)).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: 'test'), data: 'test', statusCode: 200));
      final response = await apiService.get('test');
      expect(response.statusCode, 200);
    });

    test('post', () async {
      when(dio.post(any, data: anyNamed('data'))).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: 'test'), data: 'test', statusCode: 200));
      final response = await apiService.post('test', data: {'key': 'value'});
      expect(response.statusCode, 200);
    });
  });
}
