import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/transitions/providers/transition_provider.dart';
import 'package:passdriver/features/transitions/widgets/transition_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransitionProvider()),
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
        body: TransitionWidget(),
      ),
    );
  }
}
