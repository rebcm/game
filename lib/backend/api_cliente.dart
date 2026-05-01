import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constantes.dart';
import '../mundo/chunk.dart';

class ApiCliente {
  static final ApiCliente _instancia = ApiCliente._();
  factory ApiCliente() => _instancia;
  ApiCliente._();

  final _http = http.Client();
  String? _tokenJwt;

  bool get autenticado => _tokenJwt != null;

  Map<String, String> get _cabecalhos => {
    'Content-Type': 'application/json',
    if (_tokenJwt != null) 'Authorization': 'Bearer $_tokenJwt',
  };

  Future<bool> entrar(String nomeUsuario, String senha) async {
    try {
      final resp = await _http
          .post(
            Uri.parse('${Constantes.urlApi}/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': nomeUsuario, 'password': senha}),
          )
          .timeout(Constantes.timeoutRequisicao);

      if (resp.statusCode == 200) {
        final dados = jsonDecode(resp.body) as Map<String, dynamic>;
        _tokenJwt = dados['token'] as String?;
        return _tokenJwt != null;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> salvarChunk(Chunk chunk) async {
    if (!autenticado) return false;
    try {
      final resp = await _http
          .post(
            Uri.parse('${Constantes.urlApi}/mundos/chunks'),
            headers: _cabecalhos,
            body: jsonEncode(chunk.paraJson()),
          )
          .timeout(Constantes.timeoutRequisicao);
      return resp.statusCode == 200 || resp.statusCode == 201;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> carregarChunk(int cx, int cz) async {
    if (!autenticado) return null;
    try {
      final resp = await _http
          .get(
            Uri.parse('${Constantes.urlApi}/mundos/chunks/$cx/$cz'),
            headers: _cabecalhos,
          )
          .timeout(Constantes.timeoutRequisicao);
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body) as Map<String, dynamic>;
      }
    } catch (_) {}
    return null;
  }

  Future<List<Map<String, dynamic>>> listarMundos() async {
    if (!autenticado) return [];
    try {
      final resp = await _http
          .get(
            Uri.parse('${Constantes.urlApi}/mundos'),
            headers: _cabecalhos,
          )
          .timeout(Constantes.timeoutRequisicao);
      if (resp.statusCode == 200) {
        final dados = jsonDecode(resp.body) as List<dynamic>;
        return dados.cast<Map<String, dynamic>>();
      }
    } catch (_) {}
    return [];
  }

  void sair() => _tokenJwt = null;
}
