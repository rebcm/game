import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'edge_cases/api_token_auth_failure_test.dart' as api_token_auth_failure_test;
import 'edge_cases/upload_timeout_test.dart' as upload_timeout_test;
import 'edge_cases/build_version_conflict_test.dart' as build_version_conflict_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Edge cases tests', () {
    api_token_auth_failure_test.main();
    upload_timeout_test.main();
    build_version_conflict_test.main();
  });
}
