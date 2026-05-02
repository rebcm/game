import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/rebecca_character/models/rebecca_character_model.dart';

class RebeccaCharacterProvider extends StatelessWidget {
  final Widget child;

  RebeccaCharacterProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RebeccaCharacterModel(),
      child: child,
    );
  }
}
