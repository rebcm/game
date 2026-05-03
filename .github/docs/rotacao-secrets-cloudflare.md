# Guia de Manutenção: Atualização do Cloudflare API Token no GitHub Secrets

## Introdução

Este guia descreve o processo de atualização do Cloudflare API Token armazenado como um Secret no GitHub, utilizado nos workflows do projeto `rebcm/game`.

## Pré-requisitos

1. Acesso ao repositório `rebcm/game` no GitHub com permissões para gerenciar Secrets.
2. Conta no Cloudflare com permissões para gerar e gerenciar API Tokens.

## Passo a Passo

### 1. Gerar um Novo Cloudflare API Token

1. Acesse o [painel do Cloudflare](https://dash.cloudflare.com/).
2. Navegue até **My Profile** > **API Tokens**.
3. Clique em **Create Token**.
4. Selecione o template **Edit Cloudflare Pages** ou crie um token personalizado com as permissões necessárias para o projeto.
5. Configure as permissões e recursos conforme necessário.
6. Clique em **Continue to summary** e, em seguida, **Create Token**.
7. Copie o token gerado. **Este token será exibido apenas uma vez.**

### 2. Atualizar o Secret no GitHub

1. Acesse o repositório `rebcm/game` no GitHub.
2. Navegue até **Settings** > **Actions** > **Secrets and variables** > **Actions**.
3. Localize o Secret nomeado `CLOUDFLARE_API_TOKEN`.
4. Clique em **Update** ao lado do Secret.
5. Cole o novo Cloudflare API Token gerado na etapa anterior.
6. Clique em **Update secret**.

### 3. Verificar a Atualização

1. Execute manualmente o workflow que utiliza o `CLOUDFLARE_API_TOKEN` para verificar se a atualização foi bem-sucedida.

## Considerações Finais

- Certifique-se de que o novo token tenha as permissões corretas para evitar falhas nos workflows.
- Mantenha o token seguro e não o compartilhe ou exponha em locais inseguros.

