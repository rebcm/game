import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CPU and battery consumption test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final binding = IntegrationTestWidgetsFlutterBinding.instance;

    await tester.pump(Duration(seconds: 5));

    final initialCpuUsage = await binding.traceAction(() async {
      await tester.pump(Duration(seconds: 1));
    });

    final cpuUsage = initialCpuUsage.cpuUsage;
    expect(cpuUsage, lessThan(50)); // 50% CPU usage

    print('CPU usage: $cpuUsage%');
  });
}
