import 'dart:convert';
import 'package:flutter/foundation.dart';

void main() {
  // Assuming there's a list of blocks defined somewhere in the code
  List<Block> blocks = []; // Replace with actual data fetching logic

  final output = {
    'blocks': blocks.map((block) => {
      'id': block.id,
      'name': block.name,
      'description': block.description,
    }).toList(),
  };

  print(jsonEncode(output));
}
