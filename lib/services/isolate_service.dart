import 'dart:isolate';

class IsolateService {
  static Future<SendPort> spawnIsolate() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(isolateFunction, receivePort.sendPort);
    return await receivePort.first;
  }

  static void isolateFunction(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) {
      // Handle message
    });
  }
}
