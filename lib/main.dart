import 'package:flutter/material.dart';
import 'package:rebcm/i18n/i18n_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await I18nService.instance.loadLocale('en');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: I18nService.instance.translate('game_title'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nService.instance.translate('game_title')),
      ),
      body: Center(
        child: Text(I18nService.instance.translate('hello')),
      ),
    );
  }
}
