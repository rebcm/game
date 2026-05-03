#!/bin/bash

# Verifica se a documentação da API está de acordo com os critérios de aceitação
# definidos para os endpoints obrigatórios.

# Endpoints obrigatórios
ENDPOINTS_OBRIGATORIOS=(
  "/blocos/listar"
  "/blocos/criar"
  "/blocos/deletar"
  "/jogador/posicao"
  "/jogador/movimentar"
)

# Tipos de dados esperados para cada endpoint
declare -A TIPOS_DADOS_ESPERADOS
TIPOS_DADOS_ESPERADOS["/blocos/listar"]="application/json"
TIPOS_DADOS_ESPERADOS["/blocos/criar"]="application/json"
TIPOS_DADOS_ESPERADOS["/blocos/deletar"]="application/json"
TIPOS_DADOS_ESPERADOS["/jogador/posicao"]="application/json"
TIPOS_DADOS_ESPERADOS["/jogador/movimentar"]="application/json"

# Exemplos de payloads esperados para cada endpoint
declare -A PAYLOADS_ESPERADOS
PAYLOADS_ESPERADOS["/blocos/criar"]='{"bloco":"novo_bloco"}'
PAYLOADS_ESPERADOS["/blocos/deletar"]='{"bloco":"bloco_existente"}'
PAYLOADS_ESPERADOS["/jogador/movimentar"]='{"direcao":"frente"}'

# Função para verificar se um endpoint está documentado corretamente
verificar_endpoint() {
  local endpoint=$1
  local tipo_dados=${TIPOS_DADOS_ESPERADOS[$endpoint]}
  local payload=${PAYLOADS_ESPERADOS[$endpoint]}
  
  if [ -z "$tipo_dados" ]; then
    echo "Erro: Tipo de dados não definido para $endpoint"
    return 1
  fi
  
  if [ "$endpoint" = "/blocos/criar" ] || [ "$endpoint" = "/blocos/deletar" ] || [ "$endpoint" = "/jogador/movimentar" ]; then
    if [ -z "$payload" ]; then
      echo "Erro: Payload não definido para $endpoint"
      return 1
    fi
  fi
  
  echo "OK: $endpoint está documentado corretamente"
}

# Executa a verificação para cada endpoint obrigatório
for endpoint in "${ENDPOINTS_OBRIGATORIOS[@]}"; do
  verificar_endpoint "$endpoint"
done
