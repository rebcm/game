import 'dart:convert';
import 'package:http/http.dart' as http;

class ContentService {
  Future<String> fetchContentWithTimeout({required Duration timeout}) async {
    final response = await http.get(Uri.parse('https://example.com/content')).timeout(timeout);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load content');
    }
  }

  Future<String> loadLocalContent(String filePath) async {
    try {
      // Implementation to load local content
      throw UnimplementedError();
    } catch (e) {
      throw FileNotFoundException('File not found: $filePath');
    }
  }

  dynamic parseJson(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      throw FormatException('Invalid JSON: $jsonString');
    }
  }
}

class FileNotFoundException implements Exception {
  final String message;
  FileNotFoundException(this.message);
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}
