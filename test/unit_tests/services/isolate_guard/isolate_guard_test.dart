import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/isolate_guard/isolate_guard.dart';

void main() {
  test('should run isolate and kill it', () async {
    await IsolateGuard.runIsolate(() async {
      await Future.delayed(const Duration(milliseconds: 100));
    }, debugName: 'test-isolate');
    IsolateGuard.killAllIsolates();
  });
}
