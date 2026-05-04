import 'package:flutter/material.dart';
import 'package:game/ui/components/responsive_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ResponsiveText(text: 'Rebeca'),
        ),
      ),
    );
  }
}
