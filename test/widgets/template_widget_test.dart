import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/template_widget.dart';

void main() {
  testWidgets('TemplateWidget has a text', (tester) async {
    await tester.pumpWidget(TemplateWidget());
    expect(find.text('Template Widget'), findsOneWidget);
  });
}
