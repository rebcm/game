import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/jogo/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo dispose chamado ao navegar com Navigator.pop',
      (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(EstadoJogo), findsOneWidget);
    await tester.tap(find.text('Navegar'));
    await tester.pumpAndSettle();
    expect(find.byType(EstadoJogo), findsNothing);
  });

  testWidgets('EstadoJogo dispose chamado ao navegar com pushReplacement',
      (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(EstadoJogo), findsOneWidget);
    await tester.tap(find.text('Navegar com pushReplacement'));
    await tester.pumpAndSettle();
    expect(find.byType(EstadoJogo), findsNothing);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: EstadoJogo(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NovaTela()),
            );
          },
          child: Text('Navegar'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NovaTela()),
              );
            },
            child: Text('Navegar com pushReplacement'),
          ),
        ],
      ),
    );
  }
}

class NovaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Nova Tela'),
      ),
    );
  }
}
