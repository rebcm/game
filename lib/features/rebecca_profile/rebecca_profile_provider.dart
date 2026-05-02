import 'package:flutter/material.dart';
import 'package:passdriver/features/rebecca_profile/models/rebecca_character.dart';

class RebeccaProfileProvider with ChangeNotifier {
  RebeccaCharacter _rebeccaCharacter = RebeccaCharacter(
    description: 'Rebeca é uma personagem carismática e determinada.',
    appearance: 'Ela tem cabelos castanhos e olhos verdes.',
    style: 'Seu estilo é moderno e sofisticado.',
  );

  RebeccaCharacter get rebeccaCharacter => _rebeccaCharacter;

  void updateRebeccaCharacter(RebeccaCharacter character) {
    _rebeccaCharacter = character;
    notifyListeners();
  }
}
