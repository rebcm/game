import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/rebecca_character/models/rebecca_character_model.dart';

void main() {
  group('RebeccaCharacterModel', () {
    test('initial animation is idle', () {
      final model = RebeccaCharacterModel();
      expect(model.currentAnimation, 'idle');
    });

    test('updateAnimation changes current animation', () {
      final model = RebeccaCharacterModel();
      model.updateAnimation('walk');
      expect(model.currentAnimation, 'walk');
    });
  });
}
