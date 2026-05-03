import 'package:http/http.dart' as http;

Future<void> deleteObjects() async {
  final response = await http.delete(Uri.parse('https://example.com/r2-objects'));
  if (response.statusCode != 200) {
    throw Exception('Failed to delete objects');
  }
}
