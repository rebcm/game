import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/controllers/player_controller.dart';
import 'package:rebcm/input/input_normalizer.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerController(normalizer: InputNormalizer(deadzone: 0.2))),
      ],
      child: GameWidget(),
    );
  }
}

class GameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerController = context.watch<PlayerController>();

    // Use playerController.inputX and playerController.inputY to control the player
    return Container();
  }
}
