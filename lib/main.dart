import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/trilha_sonora/providers/trilha_sonora_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrilhaSonoraProvider()),
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
      home: Scaffold(
        body: Consumer<TrilhaSonoraProvider>(
          builder: (context, trilhaSonoraProvider, child) {
            return trilhaSonoraProvider.trilhaSonora;
          },
        ),
      ),
    );
  }
}
