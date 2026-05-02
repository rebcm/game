import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';

class AssetManager with ChangeNotifier {
  final Map<String, dynamic> _loadedAssets = {};

  dynamic _loadAsset(String assetPath) async {
    if (_loadedAssets.containsKey(assetPath)) {
      return _loadedAssets[assetPath];
    }

    try {
      final ByteData data = await rootBundle.load(assetPath);
      _loadedAssets[assetPath] = data.buffer.asUint8List();
      notifyListeners();
      return _loadedAssets[assetPath];
    } catch (e) {
      print('Error loading asset: $e');
      return null;
    }
  }

  Future<dynamic> loadTexture(String texturePath) async {
    return await _loadAsset('assets/blocos/$texturePath.png');
  }

  Future<dynamic> loadModel(String modelPath) async {
    return await _loadAsset('assets/models/$modelPath.obj');
  }
}
