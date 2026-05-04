import 'package:flutter_test/flutter_test.dart';
import 'package:game/api/api.dart';
import 'package:dio/dio.dart';

void main() {
  late Dio dio;
  late Api api;

  setUp(() {
    dio = Dio();
    api = Api(dio);
  });

  test('API Load Test', () async {
    for (var i = 0; i < 100; i++) {
      final response = await api.fetchData();
      expect(response, isNotNull);
    }
  });
}
