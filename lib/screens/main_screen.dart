import 'package:flutter/material.dart';
import 'package:game/widgets/tips_display/tips_display.dart';

class MainScreen extends StatelessWidget {
  final String tip = 'This is a tip';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TipsDisplay(tip: tip),
        ],
      ),
    );
  }
}
