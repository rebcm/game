import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo is properly disposed', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EstadoJogo()),
        ],
        child: const MyApp(),
      ),
    );

    final estadoJogo = tester.state<EstadoJogo>(find.byType(EstadoJogo));

    await tester.pumpWidget(Container());

    expect(estadoJogo.mounted, false);
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
