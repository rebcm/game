#!/bin/bash

# Atualiza a checklist de documentação com os itens necessários
echo "Atualizando checklist de documentação..."

# Caminho para o arquivo de checklist
CHECKLIST_FILE="./.github/docs/documentacao_checklist/checklist.md"

# Verifica se o arquivo existe, se não, cria
if [ ! -f "$CHECKLIST_FILE" ]; then
  mkdir -p $(dirname $CHECKLIST_FILE)
  cat > $CHECKLIST_FILE << 'EOF2'
# Checklist de Documentação

## Validação de Versões

1. **Versão do Flutter/Dart**
   - [ ] Verificar compatibilidade com a versão especificada do Flutter/Dart
   - [ ] Documentar versões testadas e conhecidas por funcionar

## Conflitos de Dependências

2. **CocoaPods (iOS)**
   - [ ] Verificar resolução de conflitos de CocoaPods durante a build
   - [ ] Documentar soluções para conflitos comuns

## Tratamento de Erros

3. **Erros de Permissão em Variáveis de Ambiente**
   - [ ] Verificar tratamento de erros para permissões de variáveis de ambiente
   - [ ] Documentar como configurar permissões corretamente

## Checklist de Pré-Lançamento

- [ ] Executar `dart analyze` sem erros
- [ ] Verificar se todas as dependências estão atualizadas
- [ ] Testar em diferentes ambientes (desenvolvimento, produção)

## Referências

- [Guia de Instalação do Flutter](https://flutter.dev/docs/get-started/install)
- [Documentação do CocoaPods](https://guides.cocoapods.org/)
EOF2
else
  echo "Checklist já existe, pulando criação."
fi

echo "Checklist de documentação atualizado com sucesso!"
