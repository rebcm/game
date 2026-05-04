import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudflareApiService {
  final Dio _dio;

  CloudflareApiService(this._dio);

  Future<Response> validateToken() async {
    final token = dotenv.env['CLOUDFLARE_API_TOKEN'];
    if (token == null) {
      throw Exception('CLOUDFLARE_API_TOKEN is not set in .env file');
    }

    final response = await _dio.get(
      'https://api.cloudflare.com/client/v4/user/tokens/verify',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response;
  }
}
