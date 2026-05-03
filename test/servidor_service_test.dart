import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/servidor_service.dart';

void main() {
  group('ServidorService', () {
    test('fazerRequisicao returns a response', () async {
      final service = ServidorService();
      final response = await service.fazerRequisicao();

      expect(response.statusCode, 200);
    });
  });
}
