import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://passdriver-workers.passdriver.workers.dev/api/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      _token = jsonData['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
