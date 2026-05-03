import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/isolate_guard/isolate_guard.dart';

void main() {
  test('IsolateGuard spawns and kills isolates correctly', () async {
    await IsolateGuard.spawnIsolate(() async {}, () {});
    expect(IsolateGuard._isolates.length, 1);
    IsolateGuard.killAllIsolates();
    expect(IsolateGuard._isolates.length, 0);
  });
}
