import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_testing_controller/http_testing_controller.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/api/api_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late http.Client client;
  late ApiService apiService;
  late HttpTestingController httpTestingController;

  setUp(() {
    client = http.Client();
    apiService = ApiService(client);
    httpTestingController = HttpTestingController();
  });

  tearDown(() async {
    await httpTestingController.verify();
  });

  testWidgets('GET request success', (tester) async {
    final response = await apiService.get('https://example.com/api/data');
    expect(response.statusCode, 200);
    httpTestingController.expectOne('https://example.com/api/data').flush(http.Response('{}', 200));
  });

  testWidgets('GET request failure 404', (tester) async {
    expect(() async => await apiService.get('https://example.com/api/data')),
        throwsA(isA<http.ClientException>());
    httpTestingController.expectOne('https://example.com/api/data').flush(http.Response('Not Found', 404));
  });

  testWidgets('POST request success', (tester) async {
    final response = await apiService.post('https://example.com/api/data', {});
    expect(response.statusCode, 201);
    httpTestingController.expectOne('https://example.com/api/data').flush(http.Response('{}', 201));
  });

  testWidgets('POST request failure 500', (tester) async {
    expect(() async => await apiService.post('https://example.com/api/data', {})),
        throwsA(isA<http.ClientException>());
    httpTestingController.expectOne('https://example.com/api/data').flush(http.Response('Internal Server Error', 500));
  });
}
