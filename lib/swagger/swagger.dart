import 'package:flutter/material.dart';
import 'package:rebcm/swagger/config/swagger_config.dart';

class SwaggerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SwaggerConfig.title),
      ),
      body: Center(
        child: Text('Swagger UI will be implemented here'),
      ),
    );
  }
}
