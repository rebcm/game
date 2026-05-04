# Matriz de Hardware e KPIs

## Introdução

Este documento define a matriz de hardware e os KPIs (Key Performance Indicators) para o jogo Rebeca.

## Matriz de Hardware

A matriz de hardware é dividida em três categorias: Low, Mid e High.

### Low
- Processador: CPU dual-core
- Memória RAM: 2GB
- GPU: Adreno 505 ou equivalente

### Mid
- Processador: CPU quad-core
- Memória RAM: 4GB
- GPU: Adreno 640 ou equivalente

### High
- Processador: CPU hexa-core
- Memória RAM: 6GB
- GPU: Adreno 740 ou equivalente

## KPIs

Os KPIs definidos para o jogo são baseados na taxa de frames por segundo (FPS).

### Cenários de Uso

1. **Cenário de Construção**
   - Low: 30 FPS
   - Mid: 45 FPS
   - High: 60 FPS

2. **Cenário de Exploração**
   - Low: 40 FPS
   - Mid: 55 FPS
   - High: 60 FPS

## Implementação

Para garantir que o jogo atenda aos KPIs definidos, serão realizadas otimizações de performance, incluindo:
- Otimização de rendering
- Redução de chamadas de desenho
- Uso eficiente de memória

## Validação

A validação dos KPIs será realizada através de testes de performance em dispositivos representativos de cada categoria da matriz de hardware.
