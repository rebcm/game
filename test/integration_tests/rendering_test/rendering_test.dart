import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Renderização 3D sem interpolação', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final texture = find.byType(Image);
    expect(texture, findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 1));

    final image = tester.widget<Image>(texture);
    expect(image.filterQuality, FilterQuality.none);
  });
}
