import 'package:flutter/foundation.dart';
import 'package:rebcm/services/memory/memory_manager.dart';

class GarbageCollector {
  final MemoryManager _memoryManager;

  GarbageCollector(this._memoryManager);

  void run() {
    _memoryManager.collectGarbage();
  }
}
