import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/test_support/cleanup_d1.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await cleanupD1();

  tearDownAll(() async {
    await cleanupD1();
  });
}
