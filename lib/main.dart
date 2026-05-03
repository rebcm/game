import 'package:flutter/material.dart';
import 'package:game/widgets/construction_tips/construction_tips.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ConstructionTips(),
      ),
    );
  }
}
import 'package:game/ui/screens/dicas/dicas_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      home: DicasScreen(), // Or add a route for DicasScreen
    );
  }
}
