import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Renderização em diferentes resoluções', (tester) async {
    await tester.binding.setSurfaceSize(const Size(750, 1334)); // iPhone SE
    await tester.pumpAndSettle();
    // Adicione assertions para verificar a renderização correta

    await tester.binding.setSurfaceSize(const Size(1080, 2400)); // Pixel 7
    await tester.pumpAndSettle();
    // Adicione assertions para verificar a renderização correta

    await tester.binding.setSurfaceSize(const Size(1080, 2224)); // iPad portrait
    await tester.pumpAndSettle();
    // Adicione assertions para verificar a renderização correta

    await tester.binding.setSurfaceSize(const Size(2224, 1080)); // iPad landscape
    await tester.pumpAndSettle();
    // Adicione assertions para verificar a renderização correta

    await tester.binding.setSurfaceSize(const Size(1440, 2560)); // Samsung Galaxy Tab S8
    await tester.pumpAndSettle();
    // Adicione assertions para verificar a renderização correta
  });
}

