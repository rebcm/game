import 'package:flutter/material.dart';
import 'package:game/input_manager/input_manager.dart';
import 'package:game/control_schemes/default_control_scheme.dart';

void main() {
  final inputManager = InputManager(DefaultControlScheme());
  runApp(MyApp(inputManager));
}

class MyApp extends StatelessWidget {
  final InputManager inputManager;

  MyApp(this.inputManager);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: MyHomePage(inputManager),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final InputManager inputManager;

  MyHomePage(this.inputManager);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) => inputManager.handleKeyEvent(event),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Switch control scheme here
            },
            child: Text('Switch Control Scheme'),
          ),
        ),
      ),
    );
  }
}
