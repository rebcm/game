import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/ride_hailing/providers/ride_hailing_provider.dart';
import 'package:passdriver/features/ride_hailing/widgets/ride_hailing_map.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RideHailingProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassDriver',
      home: RideHailingMap(),
    );
  }
}
