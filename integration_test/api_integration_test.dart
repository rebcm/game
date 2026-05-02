import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/api/api_service.dart';

void main() {
  group('ApiService Integration', () {
    test('getMundos retorna lista de mundos', () async {
      final apiService = ApiService();
      final response = await apiService.getMundos();
      expect(response.statusCode, 200);
    });

    test('getMundo retorna mundo', () async {
      final apiService = ApiService();
      final response = await apiService.getMundo('1');
      expect(response.statusCode, 200);
    });

    test('criarMundo cria novo mundo', () async {
      final apiService = ApiService();
      final response = await apiService.criarMundo('novo mundo');
      expect(response.statusCode, 201);
    });

    test('atualizarMundo atualiza mundo', () async {
      final apiService = ApiService();
      final response = await apiService.atualizarMundo('1', 'mundo atualizado');
      expect(response.statusCode, 200);
    });

    test('deletarMundo deleta mundo', () async {
      final apiService = ApiService();
      final response = await apiService.deletarMundo('1');
      expect(response.statusCode, 204);
    });
  });
}
