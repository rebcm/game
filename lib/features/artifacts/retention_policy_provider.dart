import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RetentionPolicyProvider with ChangeNotifier {
  int _expirationTime = 0;

  int get expirationTime => _expirationTime;

  Future<void> updateRetentionPolicy(int expirationTime) async {
    final response = await http.post(
      Uri.parse('https://api.passdriver.com/artifacts/retention-policy'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'expirationTime': expirationTime}),
    );
    if (response.statusCode == 200) {
      _expirationTime = expirationTime;
      notifyListeners();
    } else {
      throw Exception('Falha ao atualizar política de retenção');
    }
  }

  Future<void> loadRetentionPolicy() async {
    final response = await http.get(Uri.parse('https://api.passdriver.com/artifacts/retention-policy'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _expirationTime = data['expirationTime'];
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar política de retenção');
    }
  }
}
