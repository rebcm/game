# Critérios de Aceitação: Rotação do Cloudflare API Token

## Introdução

Este documento define os critérios de aceitação para a validação da rotação do Cloudflare API Token utilizado nos workflows do projeto `rebcm/game`.

## Critérios

1. **Token Gerado Corretamente**: O novo Cloudflare API Token deve ser gerado com as permissões necessárias para o funcionamento dos workflows.
2. **Secret Atualizado**: O Secret `CLOUDFLARE_API_TOKEN` no GitHub deve ser atualizado com o novo token.
3. **Workflows Funcionando**: Os workflows que utilizam o `CLOUDFLARE_API_TOKEN` devem ser executados com sucesso após a atualização.

## Testes

1. **Teste de Geração de Token**: Verificar se o token é gerado corretamente no Cloudflare.
2. **Teste de Atualização do Secret**: Confirmar se o Secret é atualizado no GitHub.
3. **Teste de Execução de Workflows**: Executar os workflows relevantes e verificar se eles concluem sem erros.

