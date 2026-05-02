import 'package:http/http.dart' as http;
import 'package:rebcm/config/constantes.dart';

class ClienteApi {
  final http.Client _client;

  ClienteApi(this._client);

  Future<http.Response> fazerChamadaApi(String endpoint) async {
    final url = Uri.parse('${Constantes.urlApi}/$endpoint');
    return await _client.get(url);
  }
}
