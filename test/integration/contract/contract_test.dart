import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:pact/pact.dart';
import 'package:pact_http/pact_http.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Contract Tests', () {
    test('GET request test', () async {
      final pact = PactHttpVerifier(
        providerState: 'provider_state',
        pactUri: 'path_to_pact_file.json',
      );

      await pact.verify();
    });
  });
}
