import 'package:flutter/material.dart';
import 'package:rebcm/game/openapi/openapi_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rebeca Game'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: OpenAPIConfig.showOpenAPI,
            child: Text('OpenAPI Documentation'),
          ),
        ),
      ),
    );
  }
}
