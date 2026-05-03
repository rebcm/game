import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/isolate_guard/isolate_guard.dart';

void main() {
  test('IsolateGuard spawns and kills isolate correctly', () async {
    final receivePort = ReceivePort();
    await IsolateGuard.spawnIsolate('testIsolate', (message) {}, receivePort.sendPort);
    expect(IsolateGuard._activeIsolates.containsKey('testIsolate'), true);
    IsolateGuard.killIsolate('testIsolate');
    expect(IsolateGuard._activeIsolates.containsKey('testIsolate'), false);
  });

  test('IsolateGuard kills all isolates correctly', () async {
    final receivePort1 = ReceivePort();
    final receivePort2 = ReceivePort();
    await IsolateGuard.spawnIsolate('testIsolate1', (message) {}, receivePort1.sendPort);
    await IsolateGuard.spawnIsolate('testIsolate2', (message) {}, receivePort2.sendPort);
    expect(IsolateGuard._activeIsolates.length, 2);
    IsolateGuard.killAllIsolates();
    expect(IsolateGuard._activeIsolates.length, 0);
  });
}
