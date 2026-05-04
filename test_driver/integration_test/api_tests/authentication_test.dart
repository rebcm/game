import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('API token authentication failure test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Mock API token authentication failure
    final dio = Dio();
    dio.interceptors.add(MockDioInterceptor());
    try {
      await dio.get('https://api.example.com/protected');
      fail('Expected DioError');
    } on DioError catch (e) {
      expect(e.response?.statusCode, 401);
    }
  });
}

class MockDioInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Do nothing
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(DioError(
      requestOptions: err.requestOptions,
      response: Response(
        statusCode: 401,
        requestOptions: err.requestOptions,
      ),
    ));
  }
}
