import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:game/services/api_service.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('ApiService', () {
    late ApiService apiService;
    late MockDio dio;

    setUp(() {
      dio = MockDio();
      apiService = ApiService(dio);
    });

    test('checkCloudflareConnectivity returns true on success', () async {
      when(dio.get(any)).thenAnswer((_) async => Response(requestOptions: RequestOptions(), statusCode: 200));
      expect(await apiService.checkCloudflareConnectivity(), isTrue);
    });

    test('checkCloudflareConnectivity returns false on failure', () async {
      when(dio.get(any)).thenThrow(DioError(requestOptions: RequestOptions(), error: 'error'));
      expect(await apiService.checkCloudflareConnectivity(), isFalse);
    });
  });
}
