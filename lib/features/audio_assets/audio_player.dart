import 'package:audioplayers/audioplayers.dart';
import 'package:passdriver/features/audio_assets/audio_asset_loader.dart';

class AudioPlayer {
  final AudioAssetLoader _audioAssetLoader = AudioAssetLoader();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String assetPath) async {
    final String tempFilePath = await _audioAssetLoader.loadAudioAsset(assetPath);
    await _audioPlayer.play(UrlSource(tempFilePath));
  }
}
