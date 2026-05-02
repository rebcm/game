import 'package:flutter/material.dart';
import 'package:rebcm/player/rebeca_player_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: RebecaPlayerController(),
    );
  }
}
