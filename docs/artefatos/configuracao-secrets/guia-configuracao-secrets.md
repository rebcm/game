# Guia de Configuração de Secrets

Este guia detalha as chaves de API e certificados de assinatura necessários para o projeto `rebcm/game`.

## Variáveis de Ambiente

As seguintes variáveis de ambiente devem ser configuradas no CI/CD:

- `API_KEY_CLOUDFLARE`: Chave de API para autenticação no Cloudflare.
- `ANDROID_SIGNING_CERTIFICATE`: Certificado de assinatura para Android.
- `IOS_SIGNING_CERTIFICATE`: Certificado de assinatura para iOS.

## Configuração no CI/CD

1. Acesse as configurações do seu repositório no GitHub.
2. Navegue até "Actions" > "Secrets".
3. Adicione as variáveis de ambiente listadas acima com os valores correspondentes.

## Uso no Projeto

As variáveis de ambiente configuradas serão utilizadas nos workflows do GitHub Actions para:
- Autenticar no Cloudflare.
- Assinar os artefatos de release para Android e iOS.

