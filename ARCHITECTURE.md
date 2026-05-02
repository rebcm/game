# Arquitetura do Sistema de Áudio

## Visão Geral

O sistema de áudio é responsável por gerenciar a reprodução de música e efeitos sonoros no jogo.

## Componentes

- `AudioManager`: classe responsável por gerenciar a reprodução de áudio.
- `AudioProvider`: provedor de estado que encapsula o `AudioManager` e notifica os widgets dependentes.

## Funcionamento

1. O `AudioManager` utiliza a biblioteca `audioplayers` para reproduzir música e efeitos sonoros.
2. O `AudioProvider` é utilizado para fornecer o estado do áudio aos widgets.
3. Os widgets podem utilizar o `AudioProvider` para reproduzir música e efeitos sonoros.

## Exemplo de Uso
