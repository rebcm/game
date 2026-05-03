import 'dart:isolate';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_manager/chunk_isolate_guard.dart';

void main() {
  group('ChunkIsolateGuard', () {
    test('adds and kills isolates', () async {
      final guard = ChunkIsolateGuard();
      final receivePort = ReceivePort();
      final isolate = await Isolate.spawn((_) {}, receivePort.sendPort);
      guard.addIsolate(isolate);
      expect(guard._isolates.length, 1);
      guard.killAll();
      expect(guard._isolates.length, 0);
    });
  });
}
