import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/optimization/memory_optimizer.dart';

void main() {
  group('MemoryOptimizer', () {
    test('optimizeList removes null elements', () {
      List<dynamic> list = [1, null, 2, null, 3];
      MemoryOptimizer.optimizeList(list);
      expect(list, [1, 2, 3]);
    });

    test('optimizeLoop processes elements in reverse order', () {
      List<dynamic> list = [1, 2, 3];
      List<dynamic> result = [];
      MemoryOptimizer.optimizeLoop(list, (element) {
        result.add(element);
      });
      expect(result, [3, 2, 1]);
    });
  });
}
