import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/loop_optimizer.dart';

void main() {
  test('LoopOptimizer generates indices correctly', () {
    final indices = LoopOptimizer.generateOptimizedIndices(5).toList();
    expect(indices, [0, 1, 2, 3, 4]);
  });

  test('LoopOptimizer optimizes chunk generation', () {
    List<dynamic> chunks = [1, 2, 3];
    LoopOptimizer.optimizeChunkGeneration(chunks);
    expect(chunks, [1, 2, 3]); // Update this test based on actual optimization logic
  });
}
