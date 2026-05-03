import 'package:flutter/material.dart';

class BufferZone {
  final int radius;

  BufferZone({required this.radius});

  List<Chunk> getChunksToPreload(List<Chunk> allChunks, Chunk playerChunk) {
    return allChunks.where((chunk) {
      int distanceX = (chunk.x - playerChunk.x).abs();
      int distanceZ = (chunk.z - playerChunk.z).abs();
      return distanceX <= radius && distanceZ <= radius;
    }).toList();
  }
}
