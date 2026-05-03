import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Infra sanity test', (tester) async {
    // Este teste é executado pelo script run_infra_sanity_test.sh
    // e não requer implementação aqui.
  });
}
