import 'package:flutter/material.dart';
import 'package:game/main.dart' as app;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chunk Transition Stress Test',
      home: Scaffold(
        body: app.MyHomePage(),
        floatingActionButton: FloatingActionButton(
          key: Key('chunk_transition_button'),
          onPressed: () {
            // implement chunk transition logic here
          },
          tooltip: 'Transition Chunk',
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
