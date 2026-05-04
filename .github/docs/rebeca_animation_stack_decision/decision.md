# Decisão da Stack de Animação para Personagem Rebeca

## Introdução

Este documento visa documentar a decisão sobre a stack de animação a ser utilizada para o personagem Rebeca no jogo.

## Análise das Opções

Foram consideradas três opções para a implementação das animações: Lottie, Rive e Flutter Implicit Animations.

### Lottie

* Vantagens:
 + Fácil integração com o Flutter através do pacote `lottie`.
 + Suporte a animações complexas criadas no After Effects.
* Desvantagens:
 + Pode ter um impacto no desempenho devido ao tamanho dos arquivos de animação.

### Rive

* Vantagens:
 + Suporte a animações interativas e complexas.
 + Editor de animações integrado.
* Desvantagens:
 + Curva de aprendizado para o uso do editor Rive.

### Flutter Implicit Animations

* Vantagens:
 + Nativas do Flutter, não requerem pacotes adicionais.
 + Fácil de usar para animações simples.
* Desvantagens:
 + Limitadas para animações complexas.

## Decisão

Considerando a complexidade das animações da Rebeca e a necessidade de manter o jogo simples e estável, decidiu-se utilizar o Rive para as animações do personagem. O Rive oferece um bom equilíbrio entre complexidade e desempenho, além de ter um editor integrado que facilita a criação e edição das animações.

## Implementação

Para implementar as animações com Rive, será necessário:
1. Criar as animações no editor Rive.
2. Exportar as animações para o formato compatível com o pacote `rive`.
3. Integrar as animações no código do jogo utilizando o pacote `rive`.

## Conclusão

A escolha do Rive como stack de animação para o personagem Rebeca deve proporcionar uma boa experiência de jogo, mantendo a simplicidade e estabilidade do projeto.
