import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/pipeline_test/pipeline_test_page.dart';

void main() {
  testWidgets('Pipeline test page widget test', (tester) async {
    await tester.pumpWidget(PipelineTestPage());
    expect(find.text('Pipeline executado com sucesso'), findsOneWidget);
  });
}
