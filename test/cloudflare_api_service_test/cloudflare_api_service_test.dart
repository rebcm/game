import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/cloudflare_api_service.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  late Dio dio;
  late DioAdapter dioAdapter;
  late CloudflareApiService cloudflareApiService;

  setUp(() async {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    cloudflareApiService = CloudflareApiService(dio);

    await dotenv.load(fileName: '.env.example');
  });

  test('validateToken success', () async {
    dioAdapter.onGet(
      'https://api.cloudflare.com/client/v4/user/tokens/verify',
      (server) => server.reply(200, {'result': 'valid'}),
      queryParameters: {},
      data: null,
      headers: {
        'Authorization': 'Bearer test-token',
      },
    );

    dotenv.env['CLOUDFLARE_API_TOKEN'] = 'test-token';
    final response = await cloudflareApiService.validateToken();

    expect(response.statusCode, 200);
    expect(response.data, {'result': 'valid'});
  });

  test('validateToken failure', () async {
    dioAdapter.onGet(
      'https://api.cloudflare.com/client/v4/user/tokens/verify',
      (server) => server.reply(401, {'error': 'invalid token'}),
      queryParameters: {},
      data: null,
      headers: {
        'Authorization': 'Bearer invalid-token',
      },
    );

    dotenv.env['CLOUDFLARE_API_TOKEN'] = 'invalid-token';
    expect(() async => await cloudflareApiService.validateToken(),
        throwsA(isA<DioException>()));
  });
}
