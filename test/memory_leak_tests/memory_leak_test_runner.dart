import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  test('Runner de testes de vazamento de memória', () async {
    await runLeakCheckTests();
  });
}
