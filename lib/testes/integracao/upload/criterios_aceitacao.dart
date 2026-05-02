import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/constantes.dart';
import 'package:http/http.dart' as http;

class CriteriosAceitacaoUpload {
  static Future<void> verificarChecksumArquivo(String urlArquivo, String checksumEsperado) async {
    final response = await http.get(Uri.parse(urlArquivo));
    expect(response.statusCode, 200);
    final checksumReal = _calcularChecksum(response.bodyBytes);
    expect(checksumReal, checksumEsperado);
  }

  static String _calcularChecksum(List<int> bytes) {
    // Implementação real do cálculo de checksum
    // Por simplicidade, vamos supor que é uma função existente
    return Constantes.calcularChecksum(bytes);
  }

  static Future<void> verificarStatusUploaded(String idArquivo) async {
    final urlVerificacao = Uri.parse('${Constantes.urlApi}/status/$idArquivo');
    final response = await http.get(urlVerificacao);
    expect(response.statusCode, 200);
    final status = response.body;
    expect(status, 'uploaded');
  }
}
