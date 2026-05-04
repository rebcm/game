import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test Cloudflare Worker communication', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Assuming there's a button or widget that triggers the Cloudflare Worker communication
    await tester.tap(find.text('Trigger Cloudflare Worker'));
    await tester.pumpAndSettle();

    // Verify the response or the expected outcome
    expect(find.text('Expected Outcome'), findsOneWidget);

    // Optional: Directly test HTTP communication with Cloudflare Worker
    var response = await http.get(Uri.parse('https://your-cloudflare-worker-url.com/api/endpoint'));
    expect(response.statusCode, 200);
  });
}
