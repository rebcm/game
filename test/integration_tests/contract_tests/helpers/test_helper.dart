import 'package:http/http.dart' as http;

Future<http.Response> makeGetRequest(String url) async {
  return await http.get(Uri.parse(url));
}
