# Sistema de Áudio

## Visão Geral

O sistema de áudio do jogo Construção Criativa é responsável por gerenciar a reprodução de efeitos sonoros (SFX), músicas e sons ambientes. Ele utiliza a biblioteca `audioplayers` para fornecer uma experiência auditiva imersiva.

## Estrutura

- `assets/audio/optimized/`: Diretório contendo os arquivos de áudio otimizados para uso no jogo.
  - `ambient/`: Sons ambientes.
  - `music/`: Músicas de fundo.
  - `sfx/`: Efeitos sonoros.
- `lib/audio/gerenciador_audio.dart`: Classe responsável por gerenciar a reprodução de áudio.
- `lib/audio/otimizador_audio.dart`: Classe que lida com a otimização de arquivos de áudio.

## Funcionamento

1. **Carregamento de Áudio**: Os arquivos de áudio são carregados a partir do diretório `assets/audio/optimized/`.
2. **Reprodução**: A classe `GerenciadorAudio` controla a reprodução de SFX, músicas e sons ambientes.
3. **Otimização**: A classe `OtimizadorAudio` é utilizada para otimizar os arquivos de áudio para melhor performance.

## Configuração

- Os arquivos de áudio devem ser colocados nos respectivos diretórios dentro de `assets/audio/optimized/`.
- A configuração de quais áudios são carregados e reproduzidos é feita através do `GerenciadorAudio`.

## Manutenção

- Para adicionar novos áudios, basta colocá-los nos diretórios corretos e atualizar o `GerenciadorAudio` conforme necessário.
- A otimização de áudio pode ser ajustada ou melhorada modificando a lógica em `OtimizadorAudio`.
