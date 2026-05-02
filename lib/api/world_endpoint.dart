import 'dart:convert';
import 'package:http/http.dart' as http;

class WorldEndpoint {
  static const String _baseUrl = 'https://construcao-criativa.workers.dev/api/worlds';

  Future<bool> validatePayload(String name, List<int> chunkData) async {
    if (name.length < 3 || name.length > 20) return false;
    if (chunkData.length > 1024 * 1024) return false; // 1MB limit

    final response = await http.post(Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'chunkData': base64Encode(chunkData)}));
    return response.statusCode == 201;
  }
}
