import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudflareService {
  final Dio _dio = Dio();

  Future<bool> validateToken() async {
    try {
      final response = await _dio.get(
        'https://api.cloudflare.com/client/v4/user/tokens/verify',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${dotenv.env['CLOUDFLARE_API_TOKEN']}',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.data['result'] != null;
    } catch (e) {
      return false;
    }
  }
}
