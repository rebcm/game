import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadBlocoDocumentation() async {
  return await rootBundle.loadString('lib/docs/bloco_documentation/bloco_documentation.json');
}

Future<void> saveBlocoDocumentation(String jsonData) async {
  // Implement the logic to save the documentation
  // For now, just print it
  print(jsonData);
}

void main() async {
  final jsonData = await loadBlocoDocumentation();
  final jsonMap = jsonDecode(jsonData);
  // Process the jsonMap as needed
  await saveBlocoDocumentation(jsonEncode(jsonMap));
}
