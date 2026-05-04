import 'package:flutter/material.dart';
import 'package:game/utils/errors/error_handler.dart';

void main() {
  FlutterError.onError = (details) {
    ErrorHandler.handleError(details.exception, details.stack);
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca Game'),
      ),
      body: Center(
        child: Text('Hello, Rebeca!'),
      ),
    );
  }
}
