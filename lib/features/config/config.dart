import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Config with ChangeNotifier {
  String _environment = 'staging';

  String get environment => _environment;

  void setEnvironment(String environment) {
    _environment = environment;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Config()),
      ],
      child: MyApp(),
    ),
  );
}
