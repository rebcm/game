import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/isolate/isolate_communication.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Latency benchmark test', (tester) async {
    final isolateCommunication = IsolateCommunication();
    await isolateCommunication.initIsolate();

    final stopwatch = Stopwatch()..start();
    await isolateCommunication.sendMessage('test_message');
    final latency = stopwatch.elapsedMilliseconds;

    print('Latency: $latency ms');
    expect(latency, lessThan(100)); // adjust the threshold as needed
  });
}
