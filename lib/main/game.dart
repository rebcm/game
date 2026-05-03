import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/controllers/player_controller.dart';
import 'package:rebcm/input/input_normalizer.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayerController(normalizer: InputNormalizer(deadzone: 0.2)),
      child: Consumer<PlayerController>(
        builder: (context, controller, child) {
          // Use controller.inputX and controller.inputY to control the player
          return Container(); // Replace with your game widget
        },
      ),
    );
  }
}
