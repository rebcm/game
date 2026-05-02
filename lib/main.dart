import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/ride_hailing/providers/ride_hailing_provider.dart';
import 'package:passdriver/features/ride_hailing/widgets/ride_hailing_map.dart';

import 'package:passdriver/features/audio_preferences/providers/audio_preferences_provider.dart';
import 'package:passdriver/features/audio_preferences/screens/audio_preferences_screen.dart';
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
home: AudioPreferencesScreen(),
      title: 'PassDriver',
      home: RideHailingMap(),
    );
  }
}
