import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio_manager/audio_manager.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioManager()),
      ],
      child: MaterialApp(
        title: 'Rebeca\'s Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
