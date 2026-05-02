import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/providers/volume_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VolumeProvider()),
      ],
      child: MaterialApp(
        title: 'Rebeca\'s World',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
