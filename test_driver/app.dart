import 'package:flutter/material.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fade Transition Stress Test',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                key: Key('fade_in_button'),
                onPressed: () {
                  // implement fade in logic
                },
                child: Text('Fade In'),
              ),
              ElevatedButton(
                key: Key('fade_out_button'),
                onPressed: () {
                  // implement fade out logic
                },
                child: Text('Fade Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
