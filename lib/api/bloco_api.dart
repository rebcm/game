import 'package:http/http.dart' as http;
import 'package:rebcm/models/bloco.dart';

class BlocoApi {
  Future<List<Bloco>> getBlocos() async {
    final response = await http.get(Uri.parse('https://api.rebcm.com/blocos'));

    if (response.statusCode == 200) {
      // Implement JSON deserialization using json_serializable
      // For now, assume we have a fromJson factory method in Bloco class
      return (jsonDecode(response.body) as List)
          .map((data) => Bloco.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load blocos');
    }
  }
}
