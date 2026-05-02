import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/services/memory_service.dart';

void main() {
  testWidgets('Memory usage test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final memoryService = MemoryService();
    final initialMemoryUsage = await memoryService.getMemoryUsage();

    // Simulate some actions in the app
    await tester.tap(find.text('Build'));
    await tester.pumpAndSettle();

    final finalMemoryUsage = await memoryService.getMemoryUsage();
    expect(finalMemoryUsage - initialMemoryUsage, lessThan(100 * 1024 * 1024)); // 100 MB
  });
}
