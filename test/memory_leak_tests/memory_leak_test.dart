import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('estado_jogo is properly disposed', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogoWrapper(),
      ),
    );

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Verify that EstadoJogo is disposed
    // This requires implementing a way to check if EstadoJogo is disposed
    // For example, by listening to a debug stream or checking a static variable
  });
}

class EstadoJogoWrapper extends StatefulWidget {
  @override
  _EstadoJogoWrapperState createState() => _EstadoJogoWrapperState();
}

class _EstadoJogoWrapperState extends State<EstadoJogoWrapper> {
  bool showEstadoJogo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showEstadoJogo ? EstadoJogo() : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showEstadoJogo = false;
          });
        },
        child: Icon(Icons.close),
      ),
    );
  }
}
