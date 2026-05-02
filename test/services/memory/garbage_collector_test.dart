import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/memory/garbage_collector.dart';
import 'package:rebcm/services/memory/memory_manager.dart';

void main() {
  group('GarbageCollector', () {
    test('should run garbage collection', () {
      final memoryManager = MemoryManager();
      final garbageCollector = GarbageCollector(memoryManager);
      garbageCollector.run();
      // Verificar se a coleta de lixo foi executada
    });
  });
}
