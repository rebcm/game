import 'package:rebcm/services/audio/audio_service.dart';

class SoundEffectsManager {
  final AudioService _audioService;

  SoundEffectsManager(this._audioService);

  void playBlockPlacementSound() {
    _audioService.playSoundEffect('assets/audio/optimized/sfx/block_placement.mp3');
  }

  void playBlockBreakSound() {
    _audioService.playSoundEffect('assets/audio/optimized/sfx/block_break.mp3');
  }

  void playJumpSound() {
    _audioService.playSoundEffect('assets/audio/optimized/sfx/jump.mp3');
  }

  void playFlySound() {
    _audioService.playSoundEffect('assets/audio/optimized/sfx/fly.mp3');
  }

  void playInventoryOpenSound() {
    _audioService.playSoundEffect('assets/audio/optimized/sfx/inventory_open.mp3');
  }

  void playAmbientSound() {
    _audioService.playSoundEffect('assets/audio/optimized/ambient/ambient.mp3');
  }
}
