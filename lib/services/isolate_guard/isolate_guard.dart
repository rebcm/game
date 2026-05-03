import 'dart:isolate';

class IsolateGuard {
  static final Map<Capability, Isolate> _isolates = {};

  static Future<void> spawnIsolate(
    Future Function() computation,
    void Function() onComplete,
  ) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(_isolateEntry, receivePort.sendPort);
    final isolateCapability = isolate.pause(isolate.pauseCapability!);

    _isolates[isolateCapability] = isolate;

    receivePort.listen((message) {
      if (message is SendPort) {
        message.send(computation);
      } else {
        onComplete();
        _removeIsolate(isolateCapability);
      }
    });
  }

  static void _isolateEntry(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((computation) async {
      if (computation is Future Function()) {
        await computation();
        sendPort.send('done');
      }
    });
  }

  static void _removeIsolate(Capability isolateCapability) {
    _isolates[isolateCapability]?.resume(isolateCapability);
    _isolates.remove(isolateCapability);
  }

  static void killAllIsolates() {
    for (var isolate in _isolates.values) {
      isolate.kill();
    }
    _isolates.clear();
  }
}
