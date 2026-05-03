import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/services/isolate_guard/isolate_guard.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('should not leak isolates', (tester) async {
    await IsolateGuard.runIsolate(() async {
      await Future.delayed(const Duration(milliseconds: 100));
    }, debugName: 'test-isolate');
    IsolateGuard.killAllIsolates();
    // Add logic to verify isolate count
  });
}
