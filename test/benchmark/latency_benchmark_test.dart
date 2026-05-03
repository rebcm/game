import 'package:flutter_test/flutter_test.dart';
import 'package:game/your_isolate_file.dart'; // Update with actual isolate file
import 'dart:isolate';

void main() {
  test('Benchmark latency between Isolate and UI thread', () async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(yourIsolateFunction, receivePort.sendPort); // Update with actual isolate function

    final stopwatch = Stopwatch()..start();
    final message = 'benchmark_message';
    final response = await receivePort.first;
    expect(response, message);

    print('Latency: ${stopwatch.elapsed.inMilliseconds} ms');

    isolate.kill();
    receivePort.close();
  });
}
