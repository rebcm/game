import 'package:flutter/material.dart';

class R2ChunkConfig {
  static const String chunkPrefix = 'chunk-';
  static const String chunkVersionSeparator = '-v';
  static const String chunkExtension = '.dat';

  static String getChunkKey(String version, String chunkName) {
    return '$chunkPrefix$chunkName$chunkVersionSeparator$version$chunkExtension';
  }
}
