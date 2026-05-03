import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service/api_service.dart';

void main() {
  late ApiService apiService;

  setUp(() {
    apiService = ApiService.mocked();
  });

  test('test ApiService with mocked Dio', () async {
    final response = await apiService.get('/api/test');
    expect(response.statusCode, 200);
    expect(response.data, {'data': 'Mocked data'});
  });
}
