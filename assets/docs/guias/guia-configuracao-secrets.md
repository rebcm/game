# Guia de Configuração de Secrets

Este guia detalha como configurar as chaves de API e certificados de assinatura necessários para o projeto.

## Variáveis de Ambiente

As seguintes variáveis de ambiente devem ser configuradas no CI/CD:

- `API_KEY_ANDROID`: Chave de API para o Android
- `API_KEY_IOS`: Chave de API para o iOS
- `CERTIFICADO_ANDROID`: Certificado de assinatura para o Android
- `CERTIFICADO_IOS`: Certificado de assinatura para o iOS

## Configuração no CI/CD

1. Acesse as configurações do seu repositório no GitHub.
2. Navegue até "Actions" > "Secrets".
3. Adicione as variáveis de ambiente listadas acima com os valores correspondentes.

## Uso no Projeto

As variáveis de ambiente configuradas serão utilizadas automaticamente pelo workflow de CI/CD.
