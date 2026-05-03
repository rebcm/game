import 'package:flutter/material.dart';
import 'package:swagger_ui/swagger_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rebeca\'s Game'),
        ),
        body: SwaggerUI(
          url: '/swagger.json',
        ),
      ),
    );
  }
}
import 'package:rebcm/game/utils/environment_config.dart';

void main() {
  EnvironmentConfig.init();
  // Rest of the main function
}
