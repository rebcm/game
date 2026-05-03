import 'dart:isolate';

class IsolateCommunication {
  late Isolate _isolate;
  late SendPort _sendPort;

  Future<void> initIsolate() async {
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_isolateEntry, receivePort.sendPort);
    _sendPort = await receivePort.first;
  }

  Future<void> sendMessage(String message) async {
    final receivePort = ReceivePort();
    _sendPort.send([message, receivePort.sendPort]);
    await receivePort.first;
  }

  static void _isolateEntry(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      final msg = message[0];
      final replyPort = message[1];
      // Process the message
      replyPort.send(null);
    });
  }
}
