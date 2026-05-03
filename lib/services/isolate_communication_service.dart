import 'dart:isolate';

class IsolateCommunicationService {
  Future<void> sendMessage(SendPort sendPort, String message) async {
    sendPort.send(message);
  }

  Future<String> receiveMessage(ReceivePort receivePort) async {
    final completer = Completer<String>();
    receivePort.listen((message) {
      completer.complete(message);
    });
    return completer.future;
  }
}
