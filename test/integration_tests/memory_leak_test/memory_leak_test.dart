import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory leak test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Navigate to the game state
    await tester.tap(find.text('Start Game'));
    await tester.pumpAndSettle();

    // Measure memory before destroying the game state
    final initialMemoryUsage = MemoryInfo.currentHeapSize;

    // Destroy the game state
    await tester.tap(find.text('Exit Game'));
    await tester.pumpAndSettle();

    // Measure memory after destroying the game state
    final finalMemoryUsage = MemoryInfo.currentHeapSize;

    // Check for memory leaks
    expect(finalMemoryUsage - initialMemoryUsage, lessThan(1024 * 1024)); // 1MB
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      home: EstadoJogo(),
    );
  }
}

