import 'package:flutter/material.dart';
import 'package:game/controllers/player_controller/player_controller.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final playerController = context.watch<PlayerController>();
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildPlayer(playerController.state),
    );
  }

  Widget _buildPlayer(PlayerStateMachine state) {
    return state.when(
      idle: () => const Text('Idle'),
      walking: () => const Text('Walking'),
      stopping: () => const Text('Stopping'),
    );
  }
}
