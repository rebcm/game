import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/config/locale_provider.dart';
import 'package:rebcm/i18n/i18n_service.dart';
import 'package:rebcm/jogo/jogo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  I18nService().init(const Locale('pt', 'BR'));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: I18nService().gameTitle,
      locale: context.watch<LocaleProvider>().locale,
      home: const Jogo(),
    );
  }
}
