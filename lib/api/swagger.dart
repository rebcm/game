import 'package:flutter/material.dart';
import 'package:swagger/swagger.dart';

class SwaggerDoc {
  static void init() {
    SwaggerConfig.config(
      title: 'Rebeca Game API',
      description: 'API documentation for Rebeca Game',
      version: '1.0.0',
      basePath: '/api',
    );

    SwaggerConfig.addPath(
      '/blocks',
      method: SwaggerMethod.get,
      summary: 'Get all blocks',
      responses: [
        SwaggerResponse(
          code: 200,
          description: 'List of blocks',
          content: [
            SwaggerContent(
              mediaType: 'application/json',
              schema: SwaggerSchema.object(
                properties: [
                  SwaggerSchemaProperty(
                    name: 'blocks',
                    type: SwaggerType.array,
                    items: SwaggerSchema.ref('Block'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
