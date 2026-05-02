import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_app/features/rebecca_character/providers/rebecca_character_provider.dart';

class RebeccaCharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RebeccaCharacterProvider>(
      builder: (context, rebeccaCharacterProvider, child) {
        // Render Rebecca character based on the provider state
      },
    );
  }
}
