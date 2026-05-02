import 'package:flutter/foundation.dart';

class MemoryManager with ChangeNotifier {
  void collectGarbage() {
    // Implementação da coleta de lixo
    // Por exemplo, limpar listas de objetos não utilizados
    debugPrint('Coleta de lixo realizada');
  }
}
