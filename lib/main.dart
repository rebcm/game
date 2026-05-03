import 'package:flutter/material.dart';
import 'package:rebcm/utils/interruption_handling/interruption_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final interruptionHandler = InterruptionHandler();
  WidgetsBinding.instance.addObserver(interruptionHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Game UI
  }
}
