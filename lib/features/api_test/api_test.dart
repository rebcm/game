import Intl.message('package:flutter_test/flutter_test.dart');
import Intl.message('package:http/http.dart') as http;
import Intl.message('package:passdriver/services/api.dart');

void main() {
  group(Intl.message('API Tests'), () {
    test(Intl.message('GET request test'), () async {
      final response = await http.get(Uri.parse(Intl.message('https://api.passdriver.com/test')));
      expect(response.statusCode, 200);
    });

    test(Intl.message('POST request test'), () async {
      final response = await http.post(Uri.parse(Intl.message('https://api.passdriver.com/test')),
          body: {Intl.message('key'): Intl.message('value')});
      expect(response.statusCode, 201);
    });
  });
}
