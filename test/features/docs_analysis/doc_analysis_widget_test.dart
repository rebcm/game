import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/docs_analysis/widgets/doc_analysis_widget.dart';

void main() {
  testWidgets('DocAnalysisWidget has a text field and a button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DocAnalysisWidget()));
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
