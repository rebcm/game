import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/features/iluminacao/iluminacao.dart';

void main() {
  testWidgets('Iluminacao widget test', (tester) async {
    await tester.pumpWidget(Iluminacao());
    expect(find.byType(Iluminacao), findsOneWidget);
  });
}
