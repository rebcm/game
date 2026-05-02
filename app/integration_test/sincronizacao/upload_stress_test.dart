import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dio/dio.dart';
import 'package:http_interceptor/http_interceptor.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Upload Stress Test', () {
    late Dio dio;

    setUp(() {
      dio = Dio();
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onError: (error, handler) {
          print('Error: ${error.message}');
          return handler.next(error);
        },
      ));
    });

    testWidgets('Upload multiple chunks simultaneously', (tester) async {
      final chunks = List.generate(10, (index) => {'data': 'chunk-$index'});
      final responses = await Future.wait(chunks.map((chunk) => dio.post('/upload', data: chunk)));
      expect(responses.every((response) => response.statusCode == 200), true);
    });

    testWidgets('Upload large file', (tester) async {
      final largeFile = List.generate(10000, (index) => {'data': 'large-data-$index'});
      final response = await dio.post('/upload', data: largeFile);
      expect(response.statusCode, 200);
    });
  });
}
