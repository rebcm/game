import 'package:rebcm/utils/loop_optimizer.dart';

class Chunk {
  List<dynamic> data;

  Chunk(this.data);

  void optimizeMemoryAllocation() {
    data = LoopOptimizer.optimizeForLoop(data, (index) => data[index]);
  }

  void iterateChunk(void Function(dynamic) callback) {
    LoopOptimizer.optimizeListIteration(data, callback);
  }
}
