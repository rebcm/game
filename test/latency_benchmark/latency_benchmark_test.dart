import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'dart:isolate';

void main() {
  testWidgets('latency benchmark test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final ReceivePort receivePort = ReceivePort();
    final SendPort sendPort = receivePort.sendPort;

    await Isolate.spawn(isolateFunction, sendPort);

    final Stopwatch stopwatch = Stopwatch()..start();
    receivePort.listen((message) {
      stopwatch.stop();
      print('Latency: ${stopwatch.elapsedMilliseconds} ms');
    });
  });
}

void isolateFunction(SendPort sendPort) {
  sendPort.send('message from isolate');
}
