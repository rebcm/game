import Intl.message('package:flutter/material.dart');
import Intl.message('package:provider/provider.dart');
import Intl.message('trilha_sonora.dart');

class TrilhaSonoraProvider with ChangeNotifier {
  TrilhaSonora _trilhaSonora;

  TrilhaSonoraProvider() {
    _trilhaSonora = TrilhaSonora();
  }

  TrilhaSonora get trilhaSonora => _trilhaSonora;
}
