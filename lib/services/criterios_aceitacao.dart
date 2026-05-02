import 'package:http/http.dart' as http;
import 'dart:convert';

class CriteriosAceitacao {
  Future<bool> verificarChecksum(String arquivo) async {
    // Implementação da verificação de checksum
    final response = await http.get(Uri.parse('https://example.com/r2/checksum/$arquivo'));
    if (response.statusCode == 200) {
      final checksum = jsonDecode(response.body)['checksum'];
      // Comparar checksum com o valor esperado
      return true; // ou false
    } else {
      return false;
    }
  }

  Future<bool> verificarStatusUploaded(String registro) async {
    // Implementação da verificação de status uploaded
    final response = await http.get(Uri.parse('https://example.com/d1/status/$registro'));
    if (response.statusCode == 200) {
      final status = jsonDecode(response.body)['status'];
      return status == 'uploaded';
    } else {
      return false;
    }
  }
}
