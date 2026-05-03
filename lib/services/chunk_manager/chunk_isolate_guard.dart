import 'dart:isolate';

class ChunkIsolateGuard {
  final List<Isolate> _isolates = [];

  void addIsolate(Isolate isolate) {
    _isolates.add(isolate);
    isolate.then((isolate) => isolate.kill(priority: Isolate.immediate));
  }

  void killAll() {
    for (var isolate in _isolates) {
      isolate.kill(priority: Isolate.immediate);
    }
    _isolates.clear();
  }
}
