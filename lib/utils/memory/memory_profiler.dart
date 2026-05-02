import 'package:flutter/foundation.dart';

class MemoryProfiler with ChangeNotifier {
  List<int> _memorySnapshots = [];

  List<int> get memorySnapshots => _memorySnapshots;

  void captureMemorySnapshot() {
    _memorySnapshots.add(DateTime.now().millisecondsSinceEpoch);
    notifyListeners();
  }

  void clearMemorySnapshots() {
    _memorySnapshots.clear();
    notifyListeners();
  }
}
