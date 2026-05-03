import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/controllers/player_controller.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('deve mudar para Walking quando tecla de movimentação for pressionada', (tester) async {
    final controller = PlayerController();
    await tester.pumpWidget(MyApp(controller: controller));
    // Simular pressionamento de tecla
    controller.handleInput(KeyboardEvent('W'));
    await tester.pump();
    expect(controller.state, PlayerState.walking);
  });

  testWidgets('deve mudar para Walking quando controle de movimentação for acionado', (tester) async {
    final controller = PlayerController();
    await tester.pumpWidget(MyApp(controller: controller));
    // Simular toque no controle de movimentação
    controller.handleInput(TouchEvent(Offset.zero));
    await tester.pump();
    expect(controller.state, PlayerState.walking);
  });
}

class MyApp extends StatelessWidget {
  final PlayerController controller;

  MyApp({required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Player State: ${controller.state}'),
        ),
      ),
    );
  }
}
