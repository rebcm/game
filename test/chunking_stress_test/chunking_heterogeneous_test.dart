import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  group('Chunking Heterogeneous Test', () {
    testWidgets('renders chunks of different sizes', (tester) async {
      await tester.pumpWidget(MyApp());

      // Simulate heterogeneous chunking
      await tester.tap(find.text('Chunking Test'));
      await tester.pumpAndSettle();

      expect(find.byType(Chunk), findsOneWidget);
    });

    testWidgets('handles complex rendering', (tester) async {
      await tester.pumpWidget(MyApp());

      // Simulate complex rendering
      await tester.tap(find.text('Complex Rendering Test'));
      await tester.pumpAndSettle();

      expect(find.byType(Chunk), findsWidgets);
    });
  });
}
