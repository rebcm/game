import 'package:flutter/material.dart';
import 'package:game/gameplay_hints/hint_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HintManager()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<HintManager>(
              builder: (context, hintManager, child) {
                return Column(
                  children: hintManager.hints.map((hint) => Text(hint)).toList(),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<HintManager>().showHint('Hint 1');
              },
              child: Text('Trigger Hint'),
            ),
          ],
        ),
      ),
    );
  }
}
