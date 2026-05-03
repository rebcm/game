import 'package:flutter/material.dart';
import 'package:game/player/player.dart';

class PlayerWidget extends StatelessWidget {
  final Player player;

  const PlayerWidget({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: player,
      builder: (context, child) {
        return Text(player.state.toString().split('.').last);
      },
    );
  }
}
