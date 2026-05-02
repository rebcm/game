import 'package:flutter/material.dart';
import 'package:passdriver/features/trilha_sonora/trilha_sonora_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrilhaSonoraProvider()),
      ],
      child: MyApp(),
    ),
  );
}
