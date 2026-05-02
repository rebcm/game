import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rebecca_character_model.dart';

class RebeccaCharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<RebeccaCharacterModel>();
    // Implement character rendering using model's skinPath and currentAnimation
    return Container(); // TO BE IMPLEMENTED
  }
}
