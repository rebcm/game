import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('D1/R2 integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate creation of a new record in D1
    await tester.tap(find.text('New Block'));
    await tester.pumpAndSettle();

    // Verify that the record is created
    expect(find.text('Block Created'), findsOneWidget);

    // Simulate upload of the first chunk to R2
    await tester.tap(find.text('Upload Chunk'));
    await tester.pumpAndSettle();

    // Verify that the chunk is uploaded
    expect(find.text('Chunk Uploaded'), findsOneWidget);

    // Verify that the D1 record is associated with the R2 chunk
    final response = await http.get(Uri.parse('https://example.com/d1-record'));
    expect(response.statusCode, 200);
    expect(response.body, contains('R2 Chunk ID'));
  });
}
