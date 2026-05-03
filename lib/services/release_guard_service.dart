import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ReleaseGuardService {
  Future<bool> isProtectedTag(String tagName) async {
    final url = '${dotenv.env['API_URL']}/protected-tags/$tagName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body == 'true';
    } else {
      return false;
    }
  }
}
