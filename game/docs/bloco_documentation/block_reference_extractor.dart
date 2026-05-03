import 'dart:convert';
import 'package:game/services/chunk_manager/chunk_lock_manager.dart';

void main() async {
  final blockReferenceMatrix = await extractBlockReferenceMatrix();
  final output = jsonEncode(blockReferenceMatrix);
  print(output);
}

Future<Map<String, dynamic>> extractBlockReferenceMatrix() async {
  // Implement the logic to extract block reference matrix
  // For demonstration purposes, a simple map is returned
  return {
    "blocks": [
      {"id": "1", "name": "Block 1", "description": "Description 1"},
      {"id": "2", "name": "Block 2", "description": "Description 2"}
    ]
  };
}
