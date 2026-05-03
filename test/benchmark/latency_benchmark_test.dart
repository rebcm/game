import 'package:flutter_test/flutter_test.dart';
import 'dart:isolate';

void main() {
  test('latency benchmark test', () async {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    final isolate = await Isolate.spawn(isolateFunction, sendPort);
    final stopwatch = Stopwatch()..start();

    receivePort.listen((message) {
      stopwatch.stop();
      print('Latency: ${stopwatch.elapsedMicroseconds} microseconds');
      expect(stopwatch.elapsedMicroseconds, isNotNull);
      receivePort.close();
      isolate.kill();
    });

    sendPort.send('message');
  });
}

void isolateFunction(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(null);
  receivePort.listen((message) {
    sendPort.send('response');
  });
}
