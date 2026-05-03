import 'package:flutter/material.dart';
import 'package:game/widgets/locale_switcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Locale locale;

  MyApp({this.locale = const Locale('en', 'US')});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      home: LocaleSwitcher(),
    );
  }
}
