import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  // Assuming BlockType is an enum with all block types
  // and BlockMetadata is a class that holds metadata for each block type
  final blockMetadata = BlockType.values.map((type) => BlockMetadata(type)).toList();
  final jsonData = jsonEncode(blockMetadata.map((meta) => meta.toJson()).toList());
  print(jsonData);
}

enum BlockType { dirt, stone, grass } // Example enum, actual values should be used

class BlockMetadata {
  final BlockType type;

  BlockMetadata(this.type);

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      // Add other metadata as needed
    };
  }
}
