import 'package:http/http.dart' as http;

class CloudflareService {
  Future<void> handleTokenError(http.Response response) async {
    if (response.statusCode == 403) {
      throw Exception('Token inválido ou insuficiente');
    } else {
      // Handle other status codes
    }
  }
}
