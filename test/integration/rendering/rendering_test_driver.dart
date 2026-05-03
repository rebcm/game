import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver?.close();
  });

  test('Renderização de chunks', () async {
    final timeline = await driver?.traceAction(() async {
      await driver?.tap(find.byType('FloatingActionButton'));
    });

    final summary = TimelineSummary.summarize(timeline!);
    summary.writeSummaryToFile('rendering_test', pretty: true);
    summary.writeTimelineToFile('rendering_test', pretty: true);

    // Verifica se houve algum frame drop durante a renderização
    expect(summary.summaryJson['counters']['frame_drop_count'], 0);
  });
}
