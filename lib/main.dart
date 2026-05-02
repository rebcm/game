import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:passdriver/features/ride_hailing/ride_hailing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassDriver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RideHailingScreen(),
    );
  }
}

