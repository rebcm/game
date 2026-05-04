import 'package:flutter_test/flutter_test.dart';
import 'package:game/benchmark/technical_comparison.dart';

void main() {
  testWidgets('TechnicalComparison widget test', (WidgetTester tester) async {
    await tester.pumpWidget(TechnicalComparison());
    expect(find.text('Benchmarks em desenvolvimento'), findsOneWidget);
  });
}
