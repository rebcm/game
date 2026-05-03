import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:isolate';

void main() {
  testWidgets('Latency benchmark test', (tester) async {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    await tester.runAsync(() async {
      final isolate = await Isolate.spawn(isolateFunction, sendPort);
      final stopwatch = Stopwatch()..start();

      receivePort.listen((message) {
        stopwatch.stop();
        print('Latency: ${stopwatch.elapsedMicroseconds} microseconds');
      });
    });

    receivePort.close();
  });
}

void isolateFunction(SendPort sendPort) {
  sendPort.send('Message from isolate');
}
