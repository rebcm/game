import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/rebecca_character/models/rebecca_character_model.dart';

void main() {
  test('RebeccaCharacterModel initializes correctly', () {
    final model = RebeccaCharacterModel();
    expect(model.skinPath, 'assets/characters/rebeca_skin.png');
  });

  test('RebeccaCharacterModel updates animation correctly', () {
    final model = RebeccaCharacterModel();
    model.updateAnimation('walk');
    expect(model.currentAnimation, 'walk');
  });
}
