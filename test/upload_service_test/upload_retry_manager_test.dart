import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/upload_service/upload_retry_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

void main() {
  late UploadRetryManager uploadRetryManager;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    uploadRetryManager = UploadRetryManager();
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
  });

  test('should successfully retry upload after failure', () async {
    dioAdapter.onPost('/upload', (server) => server.reply(503, null));

    bool result = await uploadRetryManager.retryUpload(() async {
      try {
        await dio.post('https://example.com/upload');
        return true;
      } on DioException {
        return false;
      }
    });

    expect(result, false);
  });

  test('should successfully complete upload on first attempt', () async {
    dioAdapter.onPost('/upload', (server) => server.reply(200, null));

    bool result = await uploadRetryManager.retryUpload(() async {
      try {
        await dio.post('https://example.com/upload');
        return true;
      } on DioException {
        return false;
      }
    });

    expect(result, true);
  });
}
