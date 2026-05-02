import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/memory/memory_manager.dart';

void main() {
  group('MemoryManager', () {
    test('should collect garbage', () {
      final memoryManager = MemoryManager();
      memoryManager.collectGarbage();
      // Verificar se a coleta de lixo foi realizada com sucesso
    });
  });
}
