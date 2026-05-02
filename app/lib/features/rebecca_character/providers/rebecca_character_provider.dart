import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_app/features/rebecca_character/models/rebecca_character_model.dart';

class RebeccaCharacterProvider with ChangeNotifier {
  RebeccaCharacterModel _rebeccaCharacterModel;

  RebeccaCharacterProvider(this._rebeccaCharacterModel);

  RebeccaCharacterModel get rebeccaCharacterModel => _rebeccaCharacterModel;

  void updateCharacter() {
    notifyListeners();
  }
}
