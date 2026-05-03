# Matriz de Resoluções de Tela

## Introdução

Este documento define a matriz de resoluções de tela alvo para o jogo Rebeca, garantindo a cobertura adequada dos testes de renderização.

## Dispositivos Alvo

A seguir estão listados os dispositivos e resoluções que serão considerados para os testes de renderização:

| Dispositivo  | Resolução        | Densidade de Pixel |
|--------------|------------------|--------------------|
| iPhone SE    | 1080x1920        | @3x                |
| Pixel 7      | 1080x2400        | @3x                |
| Tablet Nexus | 1200x1920        | @2x                |
| iPad Mini    | 1024x768         | @2x                |

## Justificativa

A escolha desses dispositivos considera uma variedade de resoluções e densidades de pixel, garantindo que o jogo seja testado em diferentes configurações comuns no mercado.

## Implementação

Para garantir a compatibilidade com as resoluções definidas, o jogo deve ser configurado para se adaptar às diferentes densidades de pixel e resoluções de tela.

### Configuração no Flutter

No Flutter, a adaptação às diferentes resoluções pode ser feita utilizando as seguintes práticas:

- Utilizar widgets que se adaptam ao tamanho da tela, como `LayoutBuilder` e `MediaQuery`.
- Definir tamanhos e espaçamentos utilizando unidades relativas, como `MediaQuery.of(context).size.width` e `MediaQuery.of(context).size.height`.

### Testes

Os testes de renderização devem ser realizados em todos os dispositivos listados na matriz de resoluções. Isso garantirá que o jogo seja renderizado corretamente em diferentes configurações de tela.

## Conclusão

A definição da matriz de resoluções de tela é crucial para garantir a qualidade e a compatibilidade do jogo Rebeca em diferentes dispositivos. Seguindo as diretrizes estabelecidas neste documento, podemos assegurar que o jogo seja divertido e estável para os jogadores, independentemente do dispositivo utilizado.
