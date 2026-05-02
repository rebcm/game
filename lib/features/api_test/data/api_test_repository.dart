import 'package:http/http.dart' as http;
import 'package:passdriver/features/api_test/domain/api_test_entity.dart';

class ApiTestRepository {
  final http.Client _client;

  ApiTestRepository(this._client);

  Future<Either<Failure, ApiTestEntity>> makeApiCall() async {
    try {
      final response = await _client.get(Uri.parse('https://example.com/api/test'));
      if (response.statusCode == 200) {
        return Right(ApiTestEntity.fromJson(response.body));
      } else {
        return Left(ServerFailure('Erro ao realizar requisição'));
      }
    } catch (e) {
      return Left(ServerFailure('Erro ao realizar requisição'));
    }
  }

  Future<Either<Failure, ApiTestEntity>> makeApiCallWithError() async {
    try {
      final response = await _client.get(Uri.parse('https://example.com/api/test-error'));
      if (response.statusCode == 200) {
        return Right(ApiTestEntity.fromJson(response.body));
      } else {
        return Left(ServerFailure('Erro ao realizar requisição'));
      }
    } catch (e) {
      return Left(ServerFailure('Erro ao realizar requisição'));
    }
  }
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

abstract class Failure {
  final String message;

  Failure(this.message);
}
