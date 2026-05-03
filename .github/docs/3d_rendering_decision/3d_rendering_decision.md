# Decisão de Tecnologia de Renderização 3D

## Introdução

Este documento detalha a escolha da biblioteca de renderização 3D e engine de física para o projeto "Construção Criativa da Rebeca".

## Critérios de Seleção

1. Compatibilidade com Flutter
2. Suporte a renderização 3D de blocos voxel
3. Desempenho e otimização
4. Facilidade de integração e uso
5. Suporte a engine de física compatível

## Opções Avaliadas

1. **flutter_scene**: Biblioteca de renderização 3D para Flutter, mas com suporte limitado e comunidade pequena.
2. **three.dart** (Three.js para Dart/Flutter): Implementação Dart do Three.js, com grande comunidade e recursos, mas requer adaptação para Flutter.
3. **Integração Unity/Unreal**: Engines de jogo poderosas, mas com complexidade e peso adicionais.

## Decisão

- **Biblioteca de Renderização 3D**: three.dart (Three.js para Dart/Flutter) devido à sua grande comunidade, recursos e flexibilidade.
- **Engine de Física**: Ammo.dart (versão Dart do Ammo.js) por ser compatível com three.dart e ter boa performance.

## Justificativa

A escolha do three.dart se justifica pela sua ampla adoção e recursos. Ammo.dart é compatível e oferece boa performance para simulações físicas.

## Implementação

1. Adicionar three.dart e Ammo.dart ao `pubspec.yaml`.
2. Implementar renderização 3D básica usando three.dart.
3. Integrar Ammo.dart para simulações físicas.

## Próximos Passos

- Atualizar `pubspec.yaml` com as dependências necessárias.
- Desenvolver exemplos de uso e testes para validar a escolha.

