import 'dart:isolate';

class IsolateGuard {
  static final Map<String, Isolate> _activeIsolates = {};

  static Future<void> spawnIsolate(String id, IsolateSpawnCallback callback, SendPort? sendPort) async {
    if (_activeIsolates.containsKey(id)) {
      await _activeIsolates[id]?.kill(priority: Isolate.immediate);
    }
    final isolate = await Isolate.spawn(callback, sendPort);
    _activeIsolates[id] = isolate;
  }

  static void killIsolate(String id) {
    if (_activeIsolates.containsKey(id)) {
      _activeIsolates[id]?.kill(priority: Isolate.immediate);
      _activeIsolates.remove(id);
    }
  }

  static void killAllIsolates() {
    _activeIsolates.forEach((id, isolate) {
      isolate.kill(priority: Isolate.immediate);
    });
    _activeIsolates.clear();
  }
}
