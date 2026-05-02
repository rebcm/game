import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/performance/analisador_performance.dart';
import 'package:rebcm/jogo/jogo.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnalisadorPerformance()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebcm Game',
      home: Jogo(),
    );
  }
}
