import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Rebeca', () {
    test('can be created', () {
      expect(Rebeca(), isNotNull);
    });
  });
}
