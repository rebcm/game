import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/trilha_sonora/trilha_sonora.dart';

class TrilhaSonoraProvider with ChangeNotifier {
  late TrilhaSonora _trilhaSonora;

  TrilhaSonora get trilhaSonora => _trilhaSonora;

  TrilhaSonoraProvider() {
    _trilhaSonora = TrilhaSonora();
  }

  void iniciar() {
    // Inicia a trilha sonora
  }
}

void main() {
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TrilhaSonoraProvider()),
    ],
  );
}
