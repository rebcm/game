import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/serialization_error_handler.dart';

void main() {
  group('SerializationErrorHandler', () {
    test('handleSerializationError logs error', () {
      final handler = SerializationErrorHandler();
      final error = Exception('Erro de serialização');
      handler.handleSerializationError(error);
      // Verificar se o erro foi registrado corretamente
    });

    testWidgets('notifyUser shows snackbar', (tester) async {
      final handler = SerializationErrorHandler();
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              handler.notifyUser(context, 'Erro de serialização');
              return Container();
            },
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}

