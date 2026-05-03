import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

void main() {
  test('uploadData success', () async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onPost('/upload', (server) => server.reply(200, 'OK'));

    final apiService = ApiService();
    final response = await apiService.uploadData();

    expect(response.statusCode, 200);
  });
}
