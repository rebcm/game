import 'package:flutter/material.dart';
import 'package:game/services/walkthrough_service.dart';
import 'package:game/widgets/walkthrough_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalkthroughService()),
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
        body: WalkthroughWidget(),
      ),
    );
  }
}
