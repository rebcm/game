import 'package:flutter/material.dart';
import 'package:swagger_ui/swagger_ui.dart';

class OpenAPIConfig {
  static const String _openapiUrl = 'assets/openapi/openapi.yaml';

  static void showOpenAPI() {
    runApp(
      MaterialApp(
        title: 'OpenAPI Documentation',
        home: SwaggerUI(
          url: _openapiUrl,
        ),
      ),
    );
  }
}
