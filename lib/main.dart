import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';
import 'package:rebcm/utils/audio_asset_paths.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AudioCacheManager audioCacheManager = AudioCacheManager();
  await audioCacheManager.preloadAudioAssets(AudioAssetPaths.allAssets);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Creative World',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your existing widget tree here
    return Container();
  }
}
