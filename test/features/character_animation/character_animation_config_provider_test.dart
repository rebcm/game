import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/character_animation/models/character_animation_config.dart';
import 'package:passdriver/features/character_animation/providers/character_animation_config_provider.dart';

void main() {
  test('CharacterAnimationConfigProvider notifies listeners when config is updated', () {
    final provider = CharacterAnimationConfigProvider();
    final initialConfig = provider.config;
    var notified = false;

    provider.addListener(() {
      notified = true;
    });

    provider.updateConfig(CharacterAnimationConfig(
      tolerance: 0.1,
      maxFrameRate: 60,
      minFrameRate: 30,
    ));

    expect(notified, true);
    expect(provider.config.tolerance, 0.1);
  });
}
