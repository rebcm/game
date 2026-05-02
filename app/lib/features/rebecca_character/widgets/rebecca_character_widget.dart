import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/rebecca_character/models/rebecca_character_model.dart';

class RebeccaCharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final characterModel = context.watch<RebeccaCharacterModel>();
    // Render character based on model state
    return Image.asset(characterModel.skinPath);
  }
}
