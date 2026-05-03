import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';

void main() {
  test('Verifica se os endpoints estão documentados corretamente', () async {
    final file = File('./lib/docs/api/endpoints.yaml');
    final contents = await file.readAsString();
    final yamlMap = loadYaml(contents);

    expect(yamlMap['endpoints'], isNotNull);
    final endpoints = yamlMap['endpoints'] as List;

    expect(endpoints.length, 5);

    final endpointPaths = endpoints.map((e) => e['path']).toList();
    expect(endpointPaths, contains('/blocos/listar'));
    expect(endpointPaths, contains('/blocos/criar'));
    expect(endpointPaths, contains('/blocos/deletar'));
    expect(endpointPaths, contains('/jogador/posicao'));
    expect(endpointPaths, contains('/jogador/movimentar'));
  });
}
