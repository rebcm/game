import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class AudioAssetLoader {
  static Future<Uint8List> loadAudioAsset(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }
}
