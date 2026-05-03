import 'package:flutter/material.dart';
import 'package:rebcm/game/widgets/block_widget.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlockWidget(),
      ),
    );
  }
}
