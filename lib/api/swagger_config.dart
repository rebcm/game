import 'package:flutter/material.dart';
import 'package:swagger/swagger.dart';

void setupSwagger() {
  SwaggerConfig.config(
    title: 'Rebeca Game API',
    description: 'API documentation for Rebeca Game',
    version: '1.0.0',
    basePath: '/api',
  );
}
