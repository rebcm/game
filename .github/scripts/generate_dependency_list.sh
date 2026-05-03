#!/bin/bash

# Extrair dependências do pubspec.yaml
echo "Extraindo dependências do pubspec.yaml..."

# Criar ou atualizar o documento de dependências
mkdir -p ./.github/docs/dependencies
cat > ./.github/docs/dependencies/pubspec_dependencies.md << 'DOC_EOF'
# Dependências do Projeto

## Introdução

Este documento lista as dependências do projeto `game`, conforme especificado no arquivo `pubspec.yaml`. As dependências são categorizadas por funcionalidade e incluem as versões fixas (pinned versions) utilizadas.

## Dependências de Produção

As seguintes dependências são utilizadas em produção:

### Flutter e SDK

- `flutter`: SDK Flutter (`sdk: flutter`)

### Bibliotecas de Terceiros
DOC_EOF

yq e '.dependencies[] | select(. != "flutter") | key + ": " + . + " - " ' pubspec.yaml | while read line; do
  package=$(echo $line | cut -d':' -f1)
  version=$(echo $line | cut -d':' -f2- | xargs)
  description=$(echo "$package: pesquisa sobre $package")
  echo "- $package: $version - $description" >> ./.github/docs/dependencies/pubspec_dependencies.md
done

cat >> ./.github/docs/dependencies/pubspec_dependencies.md << 'DOC_EOF'

## Dependências de Desenvolvimento

As seguintes dependências são utilizadas apenas durante o desenvolvimento:
DOC_EOF

yq e '.dev_dependencies[] | key + ": " + . + " - " ' pubspec.yaml | while read line; do
  package=$(echo $line | cut -d':' -f1)
  version=$(echo $line | cut -d':' -f2- | xargs)
  description=$(echo "$package: pesquisa sobre $package")
  echo "- $package: $version - $description" >> ./.github/docs/dependencies/pubspec_dependencies.md
done

cat >> ./.github/docs/dependencies/pubspec_dependencies.md << 'DOC_EOF'

## Conclusão

Este documento lista as dependências do projeto `game`, categorizadas por funcionalidade. É importante manter as versões das dependências atualizadas e compatíveis com o projeto.
DOC_EOF

echo "Documento de dependências gerado com sucesso!"
