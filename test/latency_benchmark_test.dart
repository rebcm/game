import 'package:test/test.dart';
import 'dart:isolate';
import 'package:game/services/isolate_communication_service.dart';

void main() {
  test('isolate communication latency test', () async {
    final receivePort = ReceivePort();
    final sendPortCompleter = Completer<SendPort>();
    receivePort.listen((message) {
      if (message is SendPort) {
        sendPortCompleter.complete(message);
      } else {
        print('Received: $message');
      }
    });

    await Isolate.spawnUri(Uri.parse('test_driver/latency_benchmark_test_isolate.dart'), [], receivePort.sendPort);

    final sendPort = await sendPortCompleter.future;
    final isolateCommunicationService = IsolateCommunicationService();

    final stopwatch = Stopwatch()..start();
    await isolateCommunicationService.sendMessage(sendPort, 'Hello');
    final response = await isolateCommunicationService.receiveMessage(receivePort);
    stopwatch.stop();

    print('Latency: ${stopwatch.elapsedMilliseconds} ms');
    expect(response, 'Received: Hello');
  });
}
