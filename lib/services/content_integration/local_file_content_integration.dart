import 'package:game/services/content_integration/content_integration_strategy.dart';
import 'dart:io';

class LocalFileContentIntegration implements ContentIntegrationStrategy {
  final String _filePath;

  LocalFileContentIntegration(this._filePath);

  @override
  Future<String> getContent() async {
    return await File(_filePath).readAsString();
  }
}
