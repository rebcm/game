import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/asset_manager/asset_manager.dart';
import 'package:rebcm/services/asset_manager/asset_loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AssetLoader', () {
    late AssetManager assetManager;
    late AssetLoader assetLoader;

    setUp(() {
      assetManager = AssetManager();
      assetLoader = AssetLoader(assetManager);
    });

    test('loads assets', () async {
      await assetLoader.loadAssets(['assets/blocos/texture1.png', 'assets/blocos/texture2.png']);
      // Add verification that assets are loaded
    });

    test('unloads assets', () {
      assetLoader.loadAssets(['assets/blocos/texture1.png', 'assets/blocos/texture2.png']);
      assetLoader.unloadAssets(['assets/blocos/texture1.png', 'assets/blocos/texture2.png']);
      // Add verification that assets are unloaded
    });
  });
}
