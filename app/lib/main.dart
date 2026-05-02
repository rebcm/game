import 'package:flutter/material.dart';
import 'package:construcao_criativa/features/persistence/persistence_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await PersistenceManager.saveState('test', 'New Block');
            },
            child: Text('New Block'),
          ),
        ),
      ),
    );
  }
}
