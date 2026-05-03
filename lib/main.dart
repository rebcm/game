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
