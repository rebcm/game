import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/dicas_widget.dart';

void main() {
  testWidgets('Dicas widget test', (tester) async {
    await tester.pumpWidget(DicasWidget());
    expect(find.text('Dica 1'), findsOneWidget);
  });
}
