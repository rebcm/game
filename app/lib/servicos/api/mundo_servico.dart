import 'package:http/http.dart' as http;
import 'cliente_http.dart';

class MundoServico {
  final http.Client _cliente;

  MundoServico() : _cliente = ClienteHttp.criarCliente();

  Future<bool> criarMundo(String nome) async {
    final response = await _cliente.post(
      Uri.parse('https://construcao-criativa.workers.dev/api/worlds'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '{"nome": "$nome"}',
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> limiteMundos() async {
    final response = await _cliente.get(
      Uri.parse('https://construcao-criativa.workers.dev/api/worlds/limite'),
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Falha ao obter limite de mundos');
    }
  }
}
