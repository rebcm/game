import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/flujo_integracion/draw_flow.dart';

void main() {
  testWidgets('DrawFlow widget is displayed', (tester) async {
    await tester.pumpWidget(MaterialApp(home: DrawFlow()));
    expect(find.text('Fluxo de Integração da UI'), findsOneWidget);
  });
}
