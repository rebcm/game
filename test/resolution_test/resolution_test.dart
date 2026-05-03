import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  group('Resolution Test', () {
    testWidgets('Test minimum resolution', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480)); // iPhone SE resolution
      await tester.pumpWidget(app.MyApp());
      await tester.pumpAndSettle();
      expect(find.byType(app.MyApp), findsOneWidget);
    });

    testWidgets('Test another minimum resolution', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640)); // Old Android resolution
      await tester.pumpWidget(app.MyApp());
      await tester.pumpAndSettle();
      expect(find.byType(app.MyApp), findsOneWidget);
    });
  });
}
