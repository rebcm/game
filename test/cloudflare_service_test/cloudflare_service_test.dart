import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/cloudflare_service.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  group('CloudflareService', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late CloudflareService cloudflareService;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      cloudflareService = CloudflareService();
    });

    test('validateToken returns true when token is valid', () async {
      dio.httpClientAdapter = dioAdapter;
      dioAdapter.onGet(
        'https://api.cloudflare.com/client/v4/user/tokens/verify',
        (server) => server.reply(
          200,
          {
            'result': {'status': 'active'},
          },
        ),
        headers: {
          'Authorization': 'Bearer test_token',
          'Content-Type': 'application/json',
        },
      );

      final result = await cloudflareService.validateToken();
      expect(result, true);
    });

    test('validateToken returns false when token is invalid', () async {
      dio.httpClientAdapter = dioAdapter;
      dioAdapter.onGet(
        'https://api.cloudflare.com/client/v4/user/tokens/verify',
        (server) => server.reply(
          200,
          {
            'result': {'status': 'inactive'},
          },
        ),
        headers: {
          'Authorization': 'Bearer test_token',
          'Content-Type': 'application/json',
        },
      );

      final result = await cloudflareService.validateToken();
      expect(result, false);
    });
  });
}

