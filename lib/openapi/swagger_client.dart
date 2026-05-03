import 'package:flutter/material.dart';
import 'package:openapi_generator/openapi_generator.dart';

void generateSwaggerClient() async {
  final generator = OpenApiGenerator(
    inputSpecFile: 'assets/swagger.yaml',
    outputDirectory: Directory('./lib/openapi/generated'),
  );
  await generator.generate();
}

void main() {
  generateSwaggerClient();
}
