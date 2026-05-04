# Processo de Distribuição do Jogo

## Introdução

Este documento detalha o processo de distribuição do jogo Rebeca, incluindo a geração de binários e onde eles podem ser encontrados após o pipeline de CI/CD.

## Geração de Binários

Os binários do jogo são gerados automaticamente pelo pipeline de CI/CD configurado no GitHub Actions. O processo envolve as seguintes etapas:

1. **Compilação do Código**: O código Flutter é compilado para as plataformas suportadas (Android, iOS, Web, etc.).
2. **Criação de Pacotes de Distribuição**: Os binários compilados são então empacotados em formatos adequados para distribuição (APK para Android, IPA para iOS, etc.).
3. **Assinatura dos Pacotes**: Os pacotes são assinados com chaves de assinatura apropriadas para garantir a autenticidade e integridade.

## Localização dos Binários

Após a execução bem-sucedida do pipeline, os binários gerados podem ser encontrados nas seguintes localizações:

- **Artefatos do GitHub Actions**: Os binários são armazenados como artefatos nos runs do GitHub Actions. Para acessá-los, navegue até a página do workflow run correspondente e baixe os artefatos disponíveis.
- **Repositório de Releases**: Os binários também são publicados nas releases do repositório GitHub. As releases são criadas manualmente após a aprovação dos binários gerados.

## Pipeline de CI/CD

O pipeline de CI/CD é configurado para executar automaticamente em eventos específicos, como push para branches específicas ou criação de tags. A configuração detalhada do pipeline pode ser encontrada no arquivo `.github/workflows/main.yml`.

## Conclusão

O processo de distribuição do jogo Rebeca é automatizado pelo pipeline de CI/CD, garantindo a geração consistente e confiável de binários para distribuição. Os binários gerados estão disponíveis tanto como artefatos nos runs do GitHub Actions quanto nas releases do repositório.
