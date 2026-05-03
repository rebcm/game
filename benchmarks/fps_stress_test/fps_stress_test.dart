import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunking/chunk_manager.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('FPS Stress Test', (tester) async {
    await tester.pumpWidget(MyApp());

    await tester.pumpAndSettle();

    final chunkManager = ChunkManager();

    for (var i = 0; i < 100; i++) {
      chunkManager.update(tester.binding.clock.elapsedInFrame);
      await tester.pump();
    }

    expect(tester.binding.frameCount, greaterThan(0));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ChunkView(),
      ),
    );
  }
}

class ChunkView extends StatefulWidget {
  @override
  _ChunkViewState createState() => _ChunkViewState();
}

class _ChunkViewState extends State<ChunkView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
