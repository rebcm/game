import 'package:openapi_generator_cli/openapi_generator_cli.dart';
import 'dart:io';

void main(List<String> args) async {
  final config = await OpenApiGeneratorConfig.fromYamlFile(File('pubspec.yaml'));
  await generateOpenApiClient(config);
}
