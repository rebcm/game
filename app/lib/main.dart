import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/rendering/rendering_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Construção Criativa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: RenderingWidget(),
      ),
    );
  }
}
