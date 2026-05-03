# Edge Cases de Instalação

Este documento lista os cenários de erro comuns durante o setup do projeto Rebeca e fornece orientações para solucioná-los.

## Cenários de Erro

1. **Falta de Android Studio**
   - Erro: `Unable to locate Android Studio executable`
   - Solução: Instalar o Android Studio e configurar a variável de ambiente `ANDROID_STUDIO_PATH`

2. **Erro de CocoaPods**
   - Erro: `CocoaPods not installed or not in valid state`
   - Solução: Instalar o CocoaPods via Ruby: `sudo gem install cocoapods`

3. **Versão incorreta do Flutter**
   - Erro: `Flutter version not compatible`
   - Solução: Instalar a versão do Flutter especificada no `pubspec.yaml`

4. **Variáveis de ambiente não configuradas**
   - Erro: `Missing environment variables`
   - Solução: Criar um arquivo `.env` baseado no `.env.example` e preencher as variáveis necessárias

## Testes de Edge Cases

Os testes de edge cases estão localizados em `.github/workflows/artefato_limpeza_edge_cases_test.yml`. Certifique-se de que esses testes estejam passando após resolver qualquer edge case.

