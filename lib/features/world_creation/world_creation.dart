import 'package:flutter/material.dart';
import 'package:passdriver/common/providers/api_provider.dart';

class WorldCreationProvider with ChangeNotifier {
  final ApiProvider _apiProvider;

  WorldCreationProvider(this._apiProvider);

  Future<void> createWorld(String worldName) async {
    try {
      final response = await _apiProvider.post('api/worlds', {'name': worldName});
      if (response.statusCode == 201) {
        notifyListeners();
      } else {
        throw Exception('Falha ao criar mundo');
      }
    } catch (e) {
      throw Exception('Erro ao criar mundo: $e');
    }
  }
}
