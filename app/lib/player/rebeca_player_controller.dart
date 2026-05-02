import 'package:flutter/material.dart';
import 'package:rebcm/player/rebeca_player.dart';

class RebecaPlayerController extends StatefulWidget {
  @override
  _RebecaPlayerControllerState createState() => _RebecaPlayerControllerState();
}

class _RebecaPlayerControllerState extends State<RebecaPlayerController> {
  late RebecaPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = RebecaPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _player,
    );
  }

  void _handleInput() {
    // Handle input from WASD, mouse, space, E, left/right click, scroll
  }
}
