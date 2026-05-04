import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Contract Tests', () {
    late Dio dio;

    setUp(() {
      dio = Dio();
    });

    testWidgets('Validate API Endpoints', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final response = await dio.get('/api/endpoint');
      expect(response.statusCode, 200);
    });
  });
}
