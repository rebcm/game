import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'trilha_sonora.dart';

class TrilhaSonoraProvider with ChangeNotifier {
  TrilhaSonora _trilhaSonora;

  TrilhaSonoraProvider() {
    _trilhaSonora = TrilhaSonora();
  }

  TrilhaSonora get trilhaSonora => _trilhaSonora;
}
