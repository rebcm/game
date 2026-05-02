import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('D1/R2 integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate user interaction to create a new record in D1
    await tester.tap(find.text('New Record'));
    await tester.pumpAndSettle();

    // Verify that the record is created in D1
    expect(find.text('Record Created'), findsOneWidget);

    // Simulate user interaction to upload the first chunk to R2
    await tester.tap(find.text('Upload Chunk'));
    await tester.pumpAndSettle();

    // Verify that the chunk is uploaded to R2
    expect(find.text('Chunk Uploaded'), findsOneWidget);

    // Verify the integration by checking the HTTP request
    final response = await http.get(Uri.parse('https://example.com/r2/bucket'));
    expect(response.statusCode, 200);
  });
}
