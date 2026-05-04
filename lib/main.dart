import 'package:flutter/material.dart';
import 'package:game/swagger/ui/swagger_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swagger UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SwaggerUI(),
    );
  }
}
