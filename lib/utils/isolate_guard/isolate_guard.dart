import 'dart:isolate';

class IsolateGuard {
  static final Map<Isolate, String> _isolates = {};

  static Future<Isolate> spawn<T>(
    IsolateSpawnCallback<T> entryPoint,
    T message, {
    String? debugName,
  }) async {
    final isolate = await Isolate.spawn(entryPoint, message, debugName: debugName);
    _isolates[isolate] = debugName ?? 'Unknown Isolate';
    isolate.addOnExitListener(_onIsolateExit);
    return isolate;
  }

  static void _onIsolateExit() {
    final isolate = Isolate.current;
    _isolates.remove(isolate);
  }

  static void killAll() {
    for (final isolate in _isolates.keys) {
      isolate.kill(priority: Isolate.immediate);
    }
    _isolates.clear();
  }
}
