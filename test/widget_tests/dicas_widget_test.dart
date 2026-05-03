import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/dicas_widget.dart';

void main() {
  testWidgets('DicasWidget should display dicas', (tester) async {
    await tester.pumpWidget(MaterialApp(home: DicasWidget()));
    expect(find.text(DicasConstrucao.dicas[0]), findsOneWidget);
  });
}
