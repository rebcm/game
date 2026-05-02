import 'package:flutter/material.dart';
import 'package:rebcm/widgets/mouse_region_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebcm Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegionWrapper(
        child: // Your existing widget tree here,
      ),
    );
  }
}
