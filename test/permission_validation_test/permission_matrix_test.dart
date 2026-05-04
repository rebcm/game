import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:game/api_service.dart';

void main() {
  group('Permission Matrix Test', () {
    late ApiService apiService;

    setUp(() {
      apiService = ApiService(Dio());
    });

    test('Test Permission Granted vs Pipeline Result', () async {
      final permissionMatrix = [
        {'permission': 'read', 'expectedResult': 'success'},
        {'permission': 'write', 'expectedResult': 'success'},
        {'permission': 'delete', 'expectedResult': 'error_403'},
      ];

      for (var testCase in permissionMatrix) {
        final permission = testCase['permission'];
        final expectedResult = testCase['expectedResult'];

        try {
          final result = await apiService.makeRequest(permission);
          expect(result.statusCode, expectedResult == 'success' ? 200 : 403);
        } on DioException catch (e) {
          expect(e.response?.statusCode, 403);
          expect(expectedResult, 'error_403');
        }
      }
    });
  });
}
