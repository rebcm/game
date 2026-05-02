import 'package:flutter/material.dart';
import 'package:passdriver/features/audio_assets/audio_asset_loader.dart';

class AudioFeature extends StatefulWidget {
  @override
  _AudioFeatureState createState() => _AudioFeatureState();
}

class _AudioFeatureState extends State<AudioFeature> {
  final AudioAssetLoader _audioAssetLoader = AudioAssetLoader();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _audioAssetLoader.loadAudio('alert');
      },
      child: Text('Play Alert'),
    );
  }
}
