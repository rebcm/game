import 'package:flutter/material.dart';
import 'package:game/services/tips/tip_service.dart';
import 'package:game/services/tips/tip_strategy.dart';

void main() {
  runApp(MyApp());
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            TipService().showTip(context, 'This is a tip!');
          },
          child: Text('Show Tip'),
        ),
      ),
    );
  }
}
