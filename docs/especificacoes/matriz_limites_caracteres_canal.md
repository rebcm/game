# Matriz de Limites de Caracteres por Canal

A seguir, está definida a matriz de limites de caracteres para diferentes canais de comunicação do jogo, garantindo que os textos sejam exibidos corretamente sem cortes ou truncamentos.

| Canal de Comunicação | Limite de Caracteres |
| --- | --- |
| App Store (Título) | 30 |
| App Store (Descrição curta) | 80 |
| App Store (Descrição longa) | 4000 |
| Play Store (Título) | 50 |
| Play Store (Descrição curta) | 80 |
| Play Store (Descrição longa) | 4000 |
| Documentação Interna (Título) | 100 |
| Documentação Interna (Descrição) | 5000 |

## Justificativa

Os limites de caracteres foram definidos com base nas especificações técnicas de cada plataforma e nas melhores práticas para documentação interna, visando garantir a legibilidade e a integridade da informação.

## Implementação

Para implementar esses limites no código, será necessário revisar as strings utilizadas nas descrições e títulos em diferentes contextos, ajustando-as para não exceder os limites estabelecidos.

