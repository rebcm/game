import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/services/checksum/checksum_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Checksum Integration Test', () {
    late ChecksumService checksumService;

    setUp(() {
      checksumService = ChecksumService();
    });

    testWidgets('validates checksum of a resource', (tester) async {
      final url = 'https://example.com/some-resource';
      final expectedChecksum = 'some-checksum';
      final isValid = await checksumService.validateChecksum(url, expectedChecksum);
      expect(isValid, isTrue);
    });
  });
}
