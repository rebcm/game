import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CiProvider with ChangeNotifier {
  Future<void> updateArtifactRetentionPolicy(int expirationDays) async {
    final response = await http.post(
      Uri.parse('/ci/artifact-retention'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'expirationDays': expirationDays}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar política de retenção');
    }
  }
}
