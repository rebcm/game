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
      title: 'Rebeca\'s World',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<PlayerController>(
          builder: (context, playerController, child) {
            return Text('Input Value: ${playerController.inputValue}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PlayerController>(context, listen: false).updateInput(0.5);
        },
      ),
    );
  }
}
