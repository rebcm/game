import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'dart:isolate';
import 'package:flutter/foundation.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('memory test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Add your test steps here

    // Force GC before measuring memory
    final completer = Completer();
    final receivePort = ReceivePort();
    receivePort.listen((_) {
      completer.complete();
    });
    Isolate.spawn(forceGCIsolate, receivePort.sendPort);
    await completer.future;

    // Continue with your test
  });
}

void forceGCIsolate(SendPort sendPort) async {
  final receivePort = ReceivePort();
  receivePort.listen((_) {
    sendPort.send(null);
  });
  Isolate.spawn(forceGCIsolateMain, receivePort.sendPort);
}

void forceGCIsolateMain(SendPort sendPort) {
  sendPort.send(null);
}
