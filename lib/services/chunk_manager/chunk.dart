import 'package:game/services/chunk_manager/proto/chunk.pb.dart' as $pb;
import 'dart:convert';

class Chunk {
  final int x;
  final int y;
  final int z;
  final List<int> blocks;

  Chunk({required this.x, required this.y, required this.z, required this.blocks});

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'z': z,
        'blocks': blocks,
      };

  factory Chunk.fromJson(Map<String, dynamic> json) {
    return Chunk(
      x: json['x'],
      y: json['y'],
      z: json['z'],
      blocks: List<int>.from(json['blocks']),
    );
  }

  $pb.ChunkProto toProto() {
    final proto = $pb.ChunkProto();
    proto.x = x;
    proto.y = y;
    proto.z = z;
    proto.blocks.addAll(blocks);
    return proto;
  }

  factory Chunk.fromProto($pb.ChunkProto proto) {
    return Chunk(
      x: proto.x,
      y: proto.y,
      z: proto.z,
      blocks: List<int>.from(proto.blocks),
    );
  }
}

