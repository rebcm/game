import 'package:flutter/material.dart';
import 'package:game/openapi/generated/swagger.dart';

class SwaggerService {
  final ApiClient _apiClient;

  SwaggerService(this._apiClient);

  Future<void> fetchData() async {
    final response = await _apiClient.getData();
    // Process response
  }
}
