import 'package:rebcm/services/audio/sound_effects_manager.dart';

class GameLogic {
  final SoundEffectsManager _soundEffectsManager;

  GameLogic(this._soundEffectsManager);

  void onBlockPlacement() {
    _soundEffectsManager.playBlockPlacementSound();
    // Existing block placement logic
  }

  void onBlockBreak() {
    _soundEffectsManager.playBlockBreakSound();
    // Existing block break logic
  }

  void onJump() {
    _soundEffectsManager.playJumpSound();
    // Existing jump logic
  }

  void onFly() {
    _soundEffectsManager.playFlySound();
    // Existing fly logic
  }

  void onInventoryOpen() {
    _soundEffectsManager.playInventoryOpenSound();
    // Existing inventory open logic
  }

  void onGameStart() {
    _soundEffectsManager.playAmbientSound();
    // Existing game start logic
  }
}
