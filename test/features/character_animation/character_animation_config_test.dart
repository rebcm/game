import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/character_animation/models/character_animation_config.dart';
void main() {
  test('CharacterAnimationConfig is created with correct values', () {
    final config = CharacterAnimationConfig(maxTranslationSpeed: 10.0, maxFrameRate: 60.0, tolerance: 0.1);
    expect(config.maxTranslationSpeed, 10.0);
    expect(config.maxFrameRate, 60.0);
    expect(config.tolerance, 0.1);
  });
}
