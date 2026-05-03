import 'dart:convert';
import 'package:game/block_metadata.dart';

void main() {
  final blocks = BlockMetadata.getBlocks();
  final output = {
    'blocks': blocks.map((block) => {
      'id': block.id,
      'name': block.name,
      'description': block.description
    }).toList()
  };

  print(jsonEncode(output));
}
