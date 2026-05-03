import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/feedback_form/feedback_form.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('FeedbackForm', () {
    testWidgets('renders form fields and submit button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(),
          ),
        ),
      );

      expect(find.text('Passo em que ocorreu o problema'), findsOneWidget);
      expect(find.text('Descrição do problema'), findsOneWidget);
      expect(find.text('Sugestão para melhoria'), findsOneWidget);
      expect(find.text('Enviar Feedback'), findsOneWidget);
    });

    testWidgets('submits feedback successfully', (tester) async {
      final mockHttpClient = MockHttpClient();
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 201));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedbackForm(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Step 1');
      await tester.enterText(find.byType(TextFormField).at(1), 'Issue description');
      await tester.enterText(find.byType(TextFormField).at(2), 'Suggestion');

      await tester.tap(find.text('Enviar Feedback'));
      await tester.pump();

      verify(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);
    });
  });
}
