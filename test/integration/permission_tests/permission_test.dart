import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa permissão de microfone no iOS', (tester) async {
    // Implementar teste para NSMicrophoneUsageDescription
  });

  testWidgets('Testa permissão RECORD_AUDIO no Android', (tester) async {
    // Implementar teste para RECORD_AUDIO
  });
}
