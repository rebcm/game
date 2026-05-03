import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:pact/pact.dart';
import 'package:pact_http/pact_http.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Contract Tests', () {
    test('GET request test', () async {
      final pact = PactHttpClient('http://example.com');
      await pact.get('/api/endpoint')
        .then((response) => expect(response.statusCode, 200));
      await pact.verify();
    });
  });
}
