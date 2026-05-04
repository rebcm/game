import 'dart:convert';
import 'package:http/http.dart' as http;

class ContentLoader {
  static Future<void> loadContent({Duration timeout = const Duration(seconds: 10)}) async {
    try {
      final response = await http.get(Uri.parse('https://example.com/content')).timeout(timeout);
      if (response.statusCode == 200) {
        parseJson(response.body);
      } else {
        throw Exception('Failed to load content');
      }
    } on TimeoutException {
      throw TimeoutException('Timeout during API call');
    } catch (e) {
      throw Exception('Error loading content: $e');
    }
  }

  static void parseJson(String json) {
    try {
      jsonDecode(json);
    } on FormatException {
      throw FormatException('Invalid JSON');
    }
  }

  static Future<void> loadLocalContent(String filePath) async {
    try {
      // Simulate loading local content
      // For actual implementation, read the file here
      throw FileSystemException('File not found', filePath);
    } catch (e) {
      throw FileSystemException('Error loading local content: $e', filePath);
    }
  }
}
