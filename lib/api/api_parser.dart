import 'dart:convert';

class ApiParser {
  static String parseData(String jsonData) {
    try {
      final jsonMap = jsonDecode(jsonData);
      return jsonMap['data'];
    } catch (e) {
      throw Exception('Failed to parse data');
    }
  }
}
