import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'stress_test/chunk_payload_stress_test.dart' as stress_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  stress_test.main();
}
