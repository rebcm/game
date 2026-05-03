import 'dart:convert';

class OutputSchema {
  final List<Block> blocks;

  OutputSchema({required this.blocks});

  factory OutputSchema.fromJson(Map<String, dynamic> json) {
    return OutputSchema(
      blocks: (json['blocks'] as List)
          .map((block) => Block.fromJson(block))
          .toList(),
    );
  }
}

class Block {
  final String id;
  final String name;
  final String description;

  Block({required this.id, required this.name, required this.description});

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
