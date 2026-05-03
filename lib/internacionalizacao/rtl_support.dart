import 'package:flutter/material.dart';
class RTLSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ar'), 
      home: MyApp(),
    );
  }
}
