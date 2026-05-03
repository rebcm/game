import 'package:http/http.dart' as http;

Future<void> deleteRecords() async {
  final response = await http.delete(Uri.parse('https://example.com/d1-records'));
  if (response.statusCode != 200) {
    throw Exception('Failed to delete records');
  }
}
