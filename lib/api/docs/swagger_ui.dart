import 'package:flutter/material.dart';
import 'package:swagger_ui/swagger_ui.dart';
import 'openapi.yaml';

class SwaggerUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwaggerUI(
      'openapi.yaml',
      title: 'Rebeca Game API',
    );
  }
}
