import 'package:flutter/material.dart';
import 'package:game/services/isolate_service.dart';

class LatencyBenchmark with ChangeNotifier {
  int _latency = 0;

  int get latency => _latency;

  Future<void> measureLatency() async {
    final sendPort = await IsolateService.spawnIsolate();
    final stopwatch = Stopwatch()..start();

    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      stopwatch.stop();
      _latency = stopwatch.elapsedMicroseconds;
      notifyListeners();
    });

    sendPort.send('message');
  }
}
