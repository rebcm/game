class LoopOptimizer {
  static List<T> optimizeForLoop<T>(List<T> list, T Function(int) callback) {
    List<T> result = List<T>.generate(list.length, callback);
    return result;
  }

  static void optimizeListIteration(List<dynamic> list, void Function(dynamic) callback) {
    for (var element in list) {
      callback(element);
    }
  }
}
