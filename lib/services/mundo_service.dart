import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rebcm/models/mundo.dart';

class MundoService {
  final AutenticacaoService _autenticacaoService;

  MundoService(this._autenticacaoService);

  Future<bool> criarMundo(Mundo mundo) async {
    if (!await _autenticacaoService.validarIdentidadeUsuario(mundo.usuarioId)) {
      return false;
    }

    final limiteMundos = await _autenticacaoService.obterLimiteMundos(mundo.usuarioId);
    final response = await http.get(Uri.parse('https://construcao-criativa.workers.dev/api/usuarios/${mundo.usuarioId}/mundos'));
    if (response.statusCode == 200) {
      final mundos = jsonDecode(response.body).map((json) => Mundo.fromJson(json)).toList();
      if (mundos.length >= limiteMundos) {
        return false;
      }
    }

    final responseCriacao = await http.post(
      Uri.parse('https://construcao-criativa.workers.dev/api/mundos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mundo.toJson()),
    );

    return responseCriacao.statusCode == 201;
  }
}

extension MundoJson on Mundo {
  Map<String, dynamic> toJson() {
    return {'id': id, 'usuarioId': usuarioId};
  }
}
