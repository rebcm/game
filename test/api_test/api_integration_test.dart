import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/api/api.dart';
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late Dio dio;
  late Api api;

  setUp(() {
    dio = Dio();
    api = Api(dio);
  });

  testWidgets('API Integration Test', (tester) async {
    final response = await api.fetchData();
    expect(response, isNotNull);
  });
}
