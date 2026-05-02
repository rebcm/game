import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/main.dart' as app;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HTTP Error Handling', () {
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      http.Cliente = mockHttpClient;
    });

    testWidgets('400 Bad Request', (tester) async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Error 400: Bad Request'), findsOneWidget);
    });

    testWidgets('401 Unauthorized', (tester) async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Error 401: Unauthorized'), findsOneWidget);
    });

    testWidgets('404 Not Found', (tester) async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Error 404: Not Found'), findsOneWidget);
    });

    testWidgets('500 Internal Server Error', (tester) async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Error 500: Internal Server Error'), findsOneWidget);
    });

    testWidgets('Timeout', (tester) async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api')))
          .thenAnswer((_) async => Future.delayed(Duration(seconds: 10)));

      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Timeout Error'), findsOneWidget);
    });

    testWidgets('Invalid Payload', (tester) async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/api')))
          .thenAnswer((_) async => http.Response('Invalid Payload', 200));

      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Invalid Payload'), findsOneWidget);
    });
  });
}
