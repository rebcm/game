import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/checksum/checksum_service.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify checksum test', (tester) async {
    final checksumService = ChecksumService();
    final url = 'https://example.com/somefile';
    final expectedChecksum = 'expected_checksum_value';
    final result = await checksumService.verifyChecksum(url, expectedChecksum);
    expect(result, true);
  });
}
