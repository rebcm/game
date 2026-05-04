import 'package:flutter/material.dart';
import 'package:game/context_menu/context_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          ContextMenu().showContextMenu(details.globalPosition);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
        ),
      ),
    );
  }
}
