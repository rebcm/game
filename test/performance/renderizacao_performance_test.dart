import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/performance_testing/granular/renderizacao_granular.dart';
import 'package:game/utils/performance_testing/performance_tester.dart';

void main() {
  testWidgets('Comparar performance de renderização global vs granular', (tester) async {
    await tester.pumpWidget(MyApp());

    final globalFPS = await PerformanceTester.calcularFPS();
    final granularFPS = await testarRenderizacaoGranular(tester);

    expect(granularFPS, greaterThanOrEqualTo(globalFPS));
  });

  Future<int> testarRenderizacaoGranular(WidgetTester tester) async {
    await tester.pumpWidget(MyAppWithGranularRendering());
    final granularRenderizacao = RenderizacaoGranular();
    // Implementar lógica para medir FPS com renderização granular
    return granularRenderizacao.fps;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center(child: Text('Global Rendering'))));
  }
}

class MyAppWithGranularRendering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center(child: Text('Granular Rendering'))));
  }
}
