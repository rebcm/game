# Detecção de Colisão

## Introdução

A detecção de colisão é um aspecto crucial no desenvolvimento de jogos, especialmente em ambientes voxel onde a interação entre objetos é frequente. Este documento visa esclarecer as escolhas feitas para a implementação da detecção de colisão no jogo Rebeca, focando na decisão entre detecção de colisão contínua (CCD - Continuous Collision Detection) e discreta.

## Detecção de Colisão Discreta

A detecção de colisão discreta é a abordagem mais comum e simples. Ela verifica se há colisões entre objetos em intervalos de tempo discretos. Embora seja eficiente para a maioria das situações, pode falhar em detectar colisões quando objetos se movem a velocidades muito altas, resultando no efeito de "tunneling".

## Detecção de Colisão Contínua (CCD)

A CCD resolve o problema do "tunneling" verificando se há colisões ao longo do caminho percorrido por um objeto entre dois intervalos de tempo consecutivos. Isso é particularmente útil para objetos que se movem a altas velocidades.

## Implementação no Jogo Rebeca

No contexto do jogo Rebeca, a CCD será utilizada para objetos que potencialmente possam se mover a velocidades altas o suficiente para causar o efeito de "tunneling". Isso inclui principalmente o personagem principal, Rebeca, quando se move rapidamente pelo mundo voxel.

### Objetos que Requerem CCD

- **Personagem Principal (Rebeca):** Quando Rebeca se move a altas velocidades, a CCD é essencial para evitar que ela "atravesse" outros objetos sem colidir.

### Objetos que Não Requerem CCD

- **Blocos Voxel Estáticos:** Para blocos que não se movem, a detecção de colisão discreta é suficiente.
- **Objetos com Baixa Velocidade:** Objetos que se movem lentamente não necessitam de CCD, pois o risco de "tunneling" é mínimo.

## Conclusão

A escolha entre detecção de colisão discreta e contínua no jogo Rebeca depende da velocidade e natureza dos objetos envolvidos. A implementação da CCD para objetos críticos, como o personagem principal, garante uma experiência de jogo mais realista e interativa.
