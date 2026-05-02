import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/upload_test/presentation/screens/upload_test_screen.dart';

void main() {
  testWidgets('UploadTestScreen widget test', (tester) async {
    await tester.pumpWidget(UploadTestScreen());
    expect(find.text('Teste de Upload'), findsOneWidget);
  });
}
