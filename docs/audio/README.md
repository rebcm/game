# Sistema de Áudio

## Visão Geral

O sistema de áudio do jogo Rebeca é responsável por gerenciar a reprodução de efeitos sonoros, música e sons ambientes. Ele utiliza os plugins `just_audio` e `audio_service` para fornecer uma experiência de áudio imersiva.

## Arquitetura

O sistema de áudio é composto pelas seguintes camadas:

1. **Camada de Serviço**: `audio_service` fornece uma interface para gerenciar a reprodução de áudio em segundo plano.
2. **Camada de Reprodução**: `just_audio` é responsável por reproduzir arquivos de áudio.
3. **Camada de Gerenciamento**: A lógica de negócios do jogo gerencia a reprodução de áudio, incluindo a inicialização, pausa e término de faixas.

## Fluxo de Dados

1. **Carregamento de Áudio**: Os arquivos de áudio são carregados a partir dos assets do jogo (`assets/audio/optimized/`).
2. **Reprodução de Áudio**: A camada de gerenciamento envia comandos para a camada de serviço para reproduzir, pausar ou parar a reprodução de áudio.
3. **Notificação de Estado**: A camada de serviço notifica a camada de gerenciamento sobre mudanças no estado de reprodução.

## Dependências

* `just_audio`: ^0.9.34
* `audio_service`: ^0.18.9

## Manutenção

Para atualizar ou modificar o sistema de áudio, siga os passos abaixo:

1. Verifique as dependências nos arquivos `pubspec.yaml`.
2. Modifique a lógica de gerenciamento de áudio conforme necessário.
3. Execute testes para garantir a funcionalidade correta.

## Testes

Os testes de áudio são executados automaticamente nos workflows do GitHub Actions, incluindo:
* `audio_integration_test.yml`
* `audio_test.yml`
* `audio_codec_test.yml`

