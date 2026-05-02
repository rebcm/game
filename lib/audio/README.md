# Sistema de Áudio

## Visão Geral

O sistema de áudio do jogo é responsável por gerenciar a reprodução de sons, música e efeitos sonoros. Ele utiliza a biblioteca `audioplayers` para fornecer uma experiência de áudio imersiva.

## Estrutura

- `assets/audio/`: Diretório contendo arquivos de áudio.
  - `raw/`: Áudios originais, sem otimização.
  - `optimized/`: Áudios otimizados para uso no jogo.
- `lib/audio/gerenciador_audio.dart`: Gerencia a reprodução de áudios.
- `lib/audio/otimizador_audio.dart`: Responsável por otimizar os áudios para uso no jogo.

## Funcionamento

1. **Carregamento de Áudios**: Os áudios são carregados a partir do diretório `assets/audio/optimized/`.
2. **Reprodução**: O `GerenciadorAudio` controla a reprodução de áudios, incluindo música ambiente e efeitos sonoros.
3. **Otimização**: O `OtimizadorAudio` é utilizado para converter áudios raw em formatos otimizados para o jogo.

## Configuração

- Áudios devem ser colocados em `assets/audio/raw/` e otimizados para `assets/audio/optimized/`.
- A configuração de quais áudios são carregados e reproduzidos é feita no `GerenciadorAudio`.

## Melhorias Futuras

- Implementar controle de volume individual para diferentes categorias de áudio.
- Suporte a mais formatos de áudio.

## Testes

Testes de áudio são essenciais para garantir que o sistema funcione corretamente. Utilize os workflows de teste de áudio disponíveis em `.github/workflows/` para validar mudanças.
