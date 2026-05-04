# Critérios de Aceitação para Performance

## Introdução

Este documento define os critérios de aceitação para a performance do jogo "Construção Criativa da Rebeca". Estes critérios visam garantir que o jogo atenda aos padrões mínimos de desempenho em dispositivos Android gama média.

## Critérios

1. **FPS Mínimo**: O jogo deve manter uma taxa de quadros (FPS) mínima de 60 em dispositivos Android gama média.
2. **Tempo de Carregamento de Assets**: O tempo de carregamento de assets deve ser inferior a 2 segundos.

## Dispositivos de Referência

Para fins de teste, consideram-se dispositivos Android gama média aqueles que possuem:
- Processador octa-core com clock de pelo menos 2.0 GHz.
- Memória RAM de 4 GB ou mais.
- Armazenamento interno de 128 GB ou mais.

## Metodologia de Teste

1. **Teste de FPS**:
   - Executar o jogo em um dispositivo de referência.
   - Medir a taxa de quadros durante uma sessão de jogo típica (por exemplo, 5 minutos de jogo contínuo).
   - Verificar se a média de FPS não é inferior a 60.

2. **Teste de Tempo de Carregamento de Assets**:
   - Executar o jogo e medir o tempo entre o início do carregamento e a disponibilidade dos assets para uso.
   - Repetir o teste várias vezes para obter uma média.

## Ferramentas de Teste

- Utilizar ferramentas de profiling disponíveis no Flutter, como o `Flutter DevTools`, para medir a performance do jogo.
- Utilizar scripts de teste automatizados para medir o tempo de carregamento de assets.

## Aprovacao

Os critérios de aceitação serão considerados atendidos se:
- A média de FPS for igual ou superior a 60.
- O tempo médio de carregamento de assets for inferior a 2 segundos.

## Revisão e Atualização

Este documento será revisado e atualizado sempre que necessário, especialmente em caso de mudanças significativas no código ou nos requisitos do jogo.
{"pt-BR": "Tradução para pt-BR"}
