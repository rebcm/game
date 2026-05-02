import 'package:flutter/material.dart';

void main({bool staging = false}) {
  // Use the staging flag to configure your app
  runApp(MyApp(staging: staging));
}

class MyApp extends StatelessWidget {
  final bool staging;

  MyApp({required this.staging});

  @override
  Widget build(BuildContext context) {
    // Implement your app logic here
    return MaterialApp(
      title: 'Rebcm Game',
      home: Scaffold(
        body: Center(
          child: Text('Rebcm Game'),
        ),
      ),
    );
  }
}
