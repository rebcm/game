import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MundosDoUsuarioRepository {
  final http.Client _client;

  MundosDoUsuarioRepository(this._client);

  Future<Either<Exception, List<MundosDoUsuario>>> getMundosDoUsuario() async {
    final response = await _client.get(Uri.parse('/api/worlds'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final mundosDoUsuario = jsonData.map((data) => MundosDoUsuario.fromJson(data)).toList();
      return Right(mundosDoUsuario);
    } else {
      return Left(Exception('Falha ao carregar mundos do usuário'));
    }
  }
}
