import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gl/flutter_gl.dart';

class AssetManager {
  final Map<String, Texture> _loadedTextures = {};

  Future<Texture> loadTexture(String assetPath) async {
    if (_loadedTextures.containsKey(assetPath)) {
      return _loadedTextures[assetPath]!;
    }

    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();

    final Texture texture = await FlutterGL.createTexture(bytes);
    _loadedTextures[assetPath] = texture;

    return texture;
  }

  void unloadTexture(String assetPath) {
    if (_loadedTextures.containsKey(assetPath)) {
      FlutterGL.deleteTexture(_loadedTextures[assetPath]!);
      _loadedTextures.remove(assetPath);
    }
  }

  void unloadAllTextures() {
    _loadedTextures.forEach((_, texture) => FlutterGL.deleteTexture(texture));
    _loadedTextures.clear();
  }
}
