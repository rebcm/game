import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/services/d1/d1_service.dart';
import 'package:rebcm/services/r2/r2_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('D1 R2 integration test', (tester) async {
    final d1Service = D1Service();
    final r2Service = R2Service();

    await d1Service.createRecord();
    await r2Service.uploadChunk();

    expect(await d1Service.getRecord(), isNotNull);
    expect(await r2Service.getChunkStatus(), 'uploaded');
  });
}
