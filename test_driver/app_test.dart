import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Renderizador Isométrico Performance', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Verificar rebuilds desnecessários', () async {
      final timeline = await driver.traceAction(() async {
        await driver.tap(find.text('Iniciar Jogo')); // Ajustar conforme necessário
      });

      final summary = TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('renderizador_performance', pretty: true);
      summary.writeTimelineToFile('renderizador_performance', pretty: true);
    });
  });
}
