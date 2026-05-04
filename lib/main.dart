import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/state_management/state_management.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StateManagement()),
      ],
      child: MyApp(),
    ),
  );
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
    final stateManagement = Provider.of<StateManagement>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca Game'),
      ),
      body: Center(
        child: Text('Counter: ${stateManagement.counter}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: stateManagement.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

