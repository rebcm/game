import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _client;

  ApiService({required http.Client client}) : _client = client;

  Future<Either<String, String>> fetchData() async {
    try {
      final response = await _client.get(Uri.parse('https://example.com/api/data')).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return Right(response.body);
      } else {
        return Left('Error ${response.statusCode}');
      }
    } on TimeoutException {
      return Left('Timeout');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
