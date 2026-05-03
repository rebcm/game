import 'dart:isolate';

class IsolateGuard {
  static final Map<Capability, Isolate> _isolates = {};

  static Future<void> runIsolate(
    Future Function() computation, {
    required String debugName,
  }) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      _isolateWrapper,
      [computation, receivePort.sendPort],
      debugName: debugName,
    );
    _isolates[isolate.pauseCapability!] = isolate;
    await receivePort.first;
    receivePort.close();
  }

  static void _isolateWrapper(List<dynamic> args) async {
    final computation = args[0];
    final sendPort = args[1];
    await computation();
    sendPort.send(null);
  }

  static void killAllIsolates() {
    for (final isolate in _isolates.values) {
      isolate.kill();
    }
    _isolates.clear();
  }
}
