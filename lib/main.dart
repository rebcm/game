import 'package:flutter/material.dart';
import 'package:game/services/input_service/input_service_web.dart' if (dart.library.io) 'package:game/services/input_service/input_service.dart';

void main() {
  if (kIsWeb) {
    final inputService = InputServiceWeb();
    inputService.init();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Creative Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your game content here
    return Container();
  }
}
