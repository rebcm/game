import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  test('Testar checksum do arquivo no R2', () async {
    // Implementação do teste de checksum
    final response = await http.get(Uri.parse('https://example.com/r2/checksum'));
    expect(response.statusCode, 200);
    final checksum = jsonDecode(response.body)['checksum'];
    expect(checksum, 'expected_checksum');
  });

  test('Testar status uploaded no registro correspondente do D1', () async {
    // Implementação do teste de status uploaded
    final response = await http.get(Uri.parse('https://example.com/d1/status'));
    expect(response.statusCode, 200);
    final status = jsonDecode(response.body)['status'];
    expect(status, 'uploaded');
  });
}
