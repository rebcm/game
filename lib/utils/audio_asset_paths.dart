class AudioAssetPaths {
  static const List<String> sfxAssets = [
    'assets/audio/optimized/sfx/block_break.mp3',
    'assets/audio/optimized/sfx/block_place.mp3',
  ];

  static const List<String> ambientAssets = [
    'assets/audio/optimized/ambient/forest.mp3',
  ];

  static const List<String> musicAssets = [
    'assets/audio/optimized/music/theme.mp3',
  ];

  static List<String> get allAssets => [...sfxAssets, ...ambientAssets, ...musicAssets];
}
