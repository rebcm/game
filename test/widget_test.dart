import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('Widget test', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
test/chunk_validation/chunk_format_test.dart
