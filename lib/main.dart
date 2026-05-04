import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/input_manager/input_manager.dart';
import 'package:game/control_schemes/control_scheme.dart';

void main() {
  final initialScheme = DefaultControlScheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputManager(initialScheme)),
      ],
      child: MyApp(),
    ),
  );
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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final inputManager = context.read<InputManager>();
            final newScheme = AlternativeControlScheme();
            inputManager.switchScheme(newScheme);
          },
          child: Text('Switch Control Scheme'),
        ),
      ),
    );
  }
}
