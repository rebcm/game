import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory leak test for EstadoJogo', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EstadoJogo()),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    await tester.pumpWidget(Container());

    await tester.pumpAndSettle();

    // Use Flutter DevTools to inspect memory usage
    // expect memory usage to be stable or decreasing
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: EstadoJogo(),
      ),
    );
  }
}
