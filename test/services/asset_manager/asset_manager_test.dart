import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/asset_manager/asset_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AssetManager', () {
    late AssetManager assetManager;

    setUp(() {
      assetManager = AssetManager();
    });

    test('loads texture', () async {
      final texture = await assetManager.loadTexture('assets/blocos/texture.png');
      expect(texture, isNotNull);
    });

    test('unloads texture', () {
      assetManager.loadTexture('assets/blocos/texture.png');
      assetManager.unloadTexture('assets/blocos/texture.png');
      // Add verification that texture is unloaded
    });

    test('unloads all textures', () {
      assetManager.loadTexture('assets/blocos/texture1.png');
      assetManager.loadTexture('assets/blocos/texture2.png');
      assetManager.unloadAllTextures();
      // Add verification that all textures are unloaded
    });
  });
}
