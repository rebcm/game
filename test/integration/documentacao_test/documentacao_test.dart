import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('documentacao teste de integração', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Rebeca Alves Moreira'), findsOneWidget);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: Scaffold(
        body: Center(
          child: Text('Rebeca Alves Moreira'),
        ),
      ),
    );
  }
}
