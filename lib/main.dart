import 'package:flutter/material.dart';
import 'package:rebcm/i18n/i18n_service.dart';
import 'package:rebcm/jogo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  I18nService().changeLocale(Locale('pt', 'BR'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: I18nService().getTitle() ?? '',
      home: Jogo(),
    );
  }
}
