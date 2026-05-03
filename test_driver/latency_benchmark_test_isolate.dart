import 'dart:isolate';
import 'package:game/services/isolate_communication_service.dart';

void main(List<String> args, SendPort sendPort) async {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  final isolateCommunicationService = IsolateCommunicationService();
  await for (var message in receivePort) {
    final response = 'Received: $message';
    isolateCommunicationService.sendMessage(sendPort, response);
  }
}
