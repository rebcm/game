import 'package:flutter/material.dart';
import 'package:game/main.dart';
import 'package:game/utils/locale.dart';

void main() {
  final locale = GameLocale.supportedLocales.first;
  final strings = <String>[];

  void extractStrings(BuildContext context) {
    final dicas = Dicas.of(context);
    strings.addAll([
      dicas.dica1,
      dicas.dica2,
      // Add more dica properties as needed
    ]);
  }

  runApp(
    MaterialApp(
      locale: locale,
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => extractStrings(context),
              child: Text('Extract Dicas Strings'),
            ),
          ),
        ),
      ),
    ),
  );

  strings.forEach((string) => print(string));
}
