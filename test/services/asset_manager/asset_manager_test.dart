import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/asset_manager/asset_manager.dart';

void main() {
  group('AssetManager', () {
    test('loads asset correctly', () async {
      final assetManager = AssetManager();
      final asset = await assetManager.loadTexture('test_texture');
      expect(asset, isNotNull);
    });

    test('returns cached asset', () async {
      final assetManager = AssetManager();
      final asset1 = await assetManager.loadTexture('test_texture');
      final asset2 = await assetManager.loadTexture('test_texture');
      expect(asset1, asset2);
    });
  });
}
