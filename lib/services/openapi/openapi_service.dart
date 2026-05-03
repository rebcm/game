import 'package:flutter/foundation.dart';

class OpenApiService with ChangeNotifier {
  String _openApiDoc = '';

  String get openApiDoc => _openApiDoc;

  Future<void> loadOpenApiDoc() async {
    final openApiYaml = await rootBundle.loadString('lib/docs/openapi/openapi.yaml');
    _openApiDoc = openApiYaml;
    notifyListeners();
  }
}
