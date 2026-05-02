import 'package:flutter/material.dart';
import 'package:passdriver/providers/dev_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DevProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
    RebecaSkin(),
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassDriver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DevEnvironment(),
    );
  }
}
