import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/pipeline_test/pipeline_test_widget.dart';

void main() {
  testWidgets('Pipeline test', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Executar Pipeline'));
    await tester.pumpAndSettle();
    expect(find.text('Pipeline executado com sucesso'), findsOneWidget);
  });
}
