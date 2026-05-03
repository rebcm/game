import 'package:flutter/material.dart';

class SwaggerConfig {
  static const String title = 'Rebeca Game API';
  static const String description = 'API documentation for Rebeca Game';
  static const String version = '1.0.0';
  static const String url = '/api-docs';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const List<String> securitySchemes = [];

  static const Map<String, String> info = {
    'title': title,
    'description': description,
    'version': version,
  };
}
