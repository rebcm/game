# Processo de Distribuição do Jogo

## Introdução

Este documento detalha o processo de distribuição do jogo Rebeca, incluindo a geração de binários e onde eles podem ser encontrados após o pipeline.

## Geração de Binários

Os binários do jogo são gerados através do pipeline de CI/CD configurado no GitHub Actions. O processo envolve as seguintes etapas:

1. **Compilação do Código**: O código Flutter é compilado para as plataformas suportadas (Android, iOS, Web, etc.).
2. **Criação de Pacotes**: Os binários compilados são então empacotados nos formatos adequados para distribuição (APK, IPA, etc.).
3. **Assinatura dos Pacotes**: Os pacotes são assinados com as chaves de assinatura apropriadas para garantir a autenticidade e integridade.

## Localização dos Binários

Após a execução bem-sucedida do pipeline, os binários gerados podem ser encontrados nos artefatos do workflow do GitHub Actions. Para acessá-los, siga os passos abaixo:

1. **Navegue até a Página do Workflow**: Vá para a página do workflow que executou o pipeline de CI/CD.
2. **Selecione a Execução**: Escolha a execução específica do workflow que você deseja verificar.
3. **Baixe os Artefatos**: Na seção de artefatos, você encontrará os binários gerados. Clique neles para baixá-los.

## Script de Atualização da Documentação

Para manter a documentação atualizada, você pode usar o script `update_distribution_docs.sh` localizado em `.github/docs/ci_cd_pipeline_documentation/`. Este script pode ser adaptado para atualizar a documentação do processo de distribuição.

