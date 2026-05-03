import 'package:swagger/swagger.dart';

void configureEndpoints(SwaggerDocument document) {
  // Example endpoint configuration
  document.paths['/example'] = SwaggerPath(
    get: SwaggerOperation(
      summary: 'Example endpoint',
      description: 'Returns an example response',
      responses: {
        '200': SwaggerResponse(
          description: 'Successful response',
          content: {
            'application/json': SwaggerMediaType(
              schema: SwaggerSchema(
                type: SwaggerType.object,
                properties: {
                  'message': SwaggerProperty(
                    type: SwaggerType.string,
                  ),
                },
              ),
            ),
          },
        ),
      },
    ),
  );
}
