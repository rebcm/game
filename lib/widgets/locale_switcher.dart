import 'package:flutter/material.dart';

class LocaleSwitcher extends StatefulWidget {
  @override
  _LocaleSwitcherState createState() => _LocaleSwitcherState();
}

class _LocaleSwitcherState extends State<LocaleSwitcher> {
  Locale _locale = Locale('en', 'US');

  void switchLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      home: Scaffold(
        body: Text('Sample Text'),
        floatingActionButton: FloatingActionButton(
          onPressed: () => switchLocale(Locale('de', 'DE')),
          tooltip: 'Switch to German',
          child: Icon(Icons.language),
        ),
      ),
    );
  }
}
