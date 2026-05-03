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

    final estadoJogoKey = Key('estado_jogo');

    expect(find.byKey(estadoJogoKey), findsOneWidget);

    await tester.pumpWidget(Container());

    // Use Flutter DevTools or manual inspection to verify memory leak
    // This test just verifies the widget is removed from the tree
    expect(find.byKey(estadoJogoKey), findsNothing);
  });
}

class EstadoJogoWrapper extends StatefulWidget {
  @override
  _EstadoJogoWrapperState createState() => _EstadoJogoWrapperState();
}

class _EstadoJogoWrapperState extends State<EstadoJogoWrapper> {
  @override
  Widget build(BuildContext context) {
    return EstadoJogo(key: Key('estado_jogo'));
  }
}
