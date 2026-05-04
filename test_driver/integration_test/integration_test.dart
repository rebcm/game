import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'api_tests/authentication_test.dart' as auth_test;
import 'upload_tests/upload_timeout_test.dart' as upload_test;
import 'build_tests/version_conflict_test.dart' as build_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Integration tests', () {
    auth_test.main();
    upload_test.main();
    build_test.main();
  });
}
