import 'dart:convert';
import 'package:game/services/chunk_manager/chunk_lock_manager.dart';

void main() async {
  final blockReference = await extractBlockReference();
  final jsonOutput = jsonEncode(blockReference);
  print(jsonOutput);
}

Future<Map<String, dynamic>> extractBlockReference() async {
  // Implement the logic to extract block reference metadata
  // For demonstration, a simple map is returned
  return {
    "blocks": [
      {"id": 1, "name": "Block 1", "description": "First block"},
      {"id": 2, "name": "Block 2", "description": "Second block"}
    ]
  };
}
