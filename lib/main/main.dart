import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/game/rebeca_game.dart';
import 'package:rebcm/input/input_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: RebecaGame(),
    );
  }
}
