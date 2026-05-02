import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/services/artefato_service.dart';
import '../mock_server/mock_server.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Artefato Test', () {
    late MockServer _mockServer;

    setUp(() async {
      _mockServer = MockServer();
      await _mockServer.start();
    });

    tearDown(() async {
      await _mockServer.stop();
    });

    testWidgets('401 Unauthorized', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      ArtefatoService artefatoService = ArtefatoService();
      expect(await artefatoService.fetchArtefato('http://localhost:8080/401'), throwsException);
    });

    testWidgets('507 Insufficient Storage', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      ArtefatoService artefatoService = ArtefatoService();
      expect(await artefatoService.fetchArtefato('http://localhost:8080/507'), throwsException);
    });
  });
}
