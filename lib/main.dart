import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/controllers/player_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerController = Provider.of<PlayerController>(context);

    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          playerController.updateInput(details.delta.dx / 100);
        },
        child: Center(
          child: Text('Input Value: ${playerController.inputValue}'),
        ),
      ),
    );
  }
}
