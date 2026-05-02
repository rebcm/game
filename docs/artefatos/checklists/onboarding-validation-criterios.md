# Critérios de Aceitação Técnica

## Introdução

Este documento define os critérios de aceitação técnica para o projeto Rebcm.

## Critérios

1. **Versão do SDK**: A versão do SDK deve estar dentro do intervalo especificado no `pubspec.yaml`.
2. **Integridade do arquivo .apk/.ipa**: O arquivo .apk/.ipa gerado deve ser válido e não corrompido.
3. **Logs de build sem warnings críticos**: O log de build não deve conter warnings críticos.

## Validação

A validação desses critérios será realizada automaticamente pelo workflow `Validacao Criterios Aceitacao Tecnicos`.
