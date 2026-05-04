import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/services/cleanup/cleanup_service.dart';
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cleanup policy configuration test', (tester) async {
    final dio = Dio();
    final cleanupService = CleanupService(dio);
    await cleanupService.configureCleanupPolicy();
  });
}
