import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ApiService apiService;
  late MockDio dio;

  setUp(() {
    dio = MockDio();
    apiService = ApiService(dio);
  });

  test('should throw exception on build version conflict', () async {
    when(dio.post(any)).thenThrow(DioException(
      requestOptions: RequestOptions(path: '/version-check'),
      response: Response(statusCode: 409, requestOptions: RequestOptions(path: '/version-check')),
    ));

    expect(() async => await apiService.checkVersion('1.0.0'), throwsA(isA<DioException>()));
  });
}
