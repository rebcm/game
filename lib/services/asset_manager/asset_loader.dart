import 'package:rebcm/services/asset_manager/asset_manager.dart';

class AssetLoader {
  final AssetManager _assetManager;

  AssetLoader(this._assetManager);

  Future<void> loadAssets(List<String> assetPaths) async {
    for (final assetPath in assetPaths) {
      await _assetManager.loadTexture(assetPath);
    }
  }

  void unloadAssets(List<String> assetPaths) {
    for (final assetPath in assetPaths) {
      _assetManager.unloadTexture(assetPath);
    }
  }
}
