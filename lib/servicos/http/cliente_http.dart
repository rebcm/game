import 'package:http/http.dart' as http;
import 'dart:convert';
import 'excecao_http.dart';

class ClienteHttp {
  final http.Client _client;

  ClienteHttp(this._client);

  Future<dynamic> get(Uri url) async {
    final response = await _client.get(url);
    return _processarResposta(response);
  }

  Future<dynamic> post(Uri url, dynamic body) async {
    final response = await _client.post(url, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    return _processarResposta(response);
  }

  dynamic _processarResposta(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(response.body);
    } else if (statusCode == 400) {
      throw ExcecaoHttp.fromJson(jsonDecode(response.body));
    } else {
      throw ExcecaoHttp(statusCode, 'Erro inesperado');
    }
  }
}
