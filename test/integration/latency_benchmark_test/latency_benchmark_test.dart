import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:isolate';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('latency benchmark test', (tester) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(isolateFunction, receivePort.sendPort);
    final sendPort = await receivePort.first as SendPort;
    final receivePort2 = ReceivePort();
    sendPort.send(receivePort2.sendPort);
    final stopwatch = Stopwatch()..start();
    await receivePort2.first;
    stopwatch.stop();
    print('Latency: ${stopwatch.elapsedMilliseconds} ms');
  });
}

void isolateFunction(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  receivePort.listen((message) {
    message.send(null);
  });
}
