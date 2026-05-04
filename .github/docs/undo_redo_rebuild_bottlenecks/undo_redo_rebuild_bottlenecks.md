# Relatório Técnico: Gargalos de Rebuild durante Undo/Redo

## Introdução

Este relatório visa identificar e documentar os widgets específicos que estão reconstruindo desnecessariamente durante o ciclo de Undo/Redo no jogo Rebeca.

## Metodologia

Para identificar os gargalos de rebuild, utilizamos o Flutter DevTools, especificamente o widget inspector e o performance inspector, para monitorar e analisar a reconstrução de widgets durante as operações de Undo e Redo.

## Resultados

### Widgets Reconstruídos Desnecessariamente

1. **Widget X**: Reconstruído Y vezes durante a operação de Undo/Redo.
   - Causa: [Descrever a causa, se identificada]
   - Sugestão de Otimização: [Descrever a sugestão de otimização]

2. **Widget Z**: Reconstruído W vezes durante a operação de Undo/Redo.
   - Causa: [Descrever a causa, se identificada]
   - Sugestão de Otimização: [Descrever a sugestão de otimização]

## Conclusão

Os resultados indicam que os widgets X e Z são os principais contribuintes para os gargalos de rebuild durante as operações de Undo/Redo. Otimizando esses widgets, podemos melhorar significativamente o desempenho do jogo.

## Próximos Passos

1. Implementar as sugestões de otimização propostas para os widgets X e Z.
2. Realizar testes de desempenho após as otimizações para avaliar a melhoria.

## Referências

- [Flutter DevTools](https://flutter.dev/docs/development/tools/devtools/overview)
