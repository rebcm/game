import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/config/input_config.dart';
import 'package:rebcm/game_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputConfig()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Voxel World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}
