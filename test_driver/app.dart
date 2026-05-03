import 'package:flutter/material.dart';
import 'package:game/main.dart' as app;

void main() {
  app.main();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentLanguage = 'English';

  void _changeLanguage(String language) {
    setState(() {
      _currentLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentLanguage == 'English'
                  ? 'Settings'
                  : _currentLanguage == 'Deutsch'
                      ? 'Einstellungen'
                      : 'Paramètres',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _changeLanguage('Deutsch'),
              child: Text('Deutsch'),
            ),
            ElevatedButton(
              onPressed: () => _changeLanguage('Français'),
              child: Text('Français'),
            ),
          ],
        ),
      ),
    );
  }
}
