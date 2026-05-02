import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Rebeca()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Consumer<Rebeca>(
            builder: (context, rebeca, child) {
              return Text(rebeca.estado);
            },
          ),
        ),
      ),
    );
  }
}
