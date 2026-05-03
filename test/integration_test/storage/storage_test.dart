import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/storage_service.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'mock_storage_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockStorageService _mockStorageService;

  setUp(() {
    _mockStorageService = MockStorageService();
    when(_mockStorageService.clearCache()).thenAnswer((_) async {});
  });

  tearDown(() {
    verify(_mockStorageService.clearCache()).called(1);
  });

  testWidgets('storage test', (tester) async {
    await tester.runAsync(() async {
      await StorageService.instance.clearCache();
    });
  });
}
