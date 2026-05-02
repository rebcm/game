import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/character_animation/providers/character_animation_provider.dart';

void main() {
  group('CharacterAnimationProvider', () {
    test('initial tolerance is 0.05', () {
      final provider = CharacterAnimationProvider();
      expect(provider.tolerance, 0.05);
    });

    test('setTolerance updates tolerance', () {
      final provider = CharacterAnimationProvider();
      provider.setTolerance(0.1);
      expect(provider.tolerance, 0.1);
    });
  });
}
