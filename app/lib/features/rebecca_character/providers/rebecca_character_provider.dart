import 'package:flutter/material.dart';
import '../models/rebecca_character_model.dart';

class RebeccaCharacterProvider with ChangeNotifier {
  late RebeccaCharacterModel _rebeccaModel;

  RebeccaCharacterProvider() {
    _rebeccaModel = RebeccaCharacterModel(skinPath: 'assets/characters/rebeca_skin.png');
  }

  RebeccaCharacterModel get rebeccaModel => _rebeccaModel;

  void updateSkin(String newSkinPath) {
    _rebeccaModel = RebeccaCharacterModel(skinPath: newSkinPath);
    notifyListeners();
  }
}
