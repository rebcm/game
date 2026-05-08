# 🎮 Walkthrough — Construção Criativa da Rebeca

**Autora:** Rebeca Alves Moreira
**Versão atual:** Pós sprint 9 — 16 mobs, 36 blocos, Nether dimension, multiplayer cross-device.

Guia passo-a-passo pra começar a jogar e dominar todas as mecânicas.

---

## 🚪 Primeira vez

1. Acesse **[https://construcao-criativa.pages.dev](https://construcao-criativa.pages.dev)**
2. Boot screen aparece:
   - **Digite seu nome** (ex: "Rebeca", "Aventureiro")
   - Você verá lista de **mundos salvos** (vazia na 1ª vez)
   - **Digite nome do novo mundo** (ex: "Meu Primeiro Mundo")
3. Clique **▶ Jogar** — entra em fullscreen + pointer lock no desktop, paisagem no celular.
4. Você nasce no Modo Sobrevivência (default), em terreno gerado por Perlin noise.

### Continuar mundo existente
Em vez de criar novo, **clique no item de um mundo na lista** — carrega de onde parou (posição, inventário, blocos modificados, achievements).

---

## 🦅 Modo Criativo

Para construir livremente sem sobrevivência:

- Aperte **`G`** pra alternar entre Criativo e Sobrevivência (toast confirma).
- **Voe** com `Espaço` (subir) e `Shift` (descer).
- **Selecione bloco** com scroll do mouse ou teclas `1`–`9`.
- **Coloque bloco** com clique direito.
- **Quebre bloco** com clique esquerdo (instantâneo no Criativo).
- **`E`** abre o **Inventário Criativo** com 8 abas + busca:
  - 🧱 Construção · 🌿 Natureza · 💎 Minérios · 💧 Líquidos
  - 🪟 Decoração · ⛏ Ferramentas · ⚔ Combate · 🍖 Comida
- Toque num item — substitui o slot ativo da hotbar com 64 unidades.

### Dicas de construção

- **`F2`** 📸 baixa screenshot PNG (esconde HUD primeiro).
- **`F5`** alterna 1ª/3ª pessoa — confira a vista de fora.
- **`F3`** mostra coordenadas, chunk, bloco mirado, light level (sky/block), FPS, stats globais, faces meshadas, players online.
- **`F1`** esconde HUD pra screenshots limpas.
- **`Tab`** libera mouse sem pausar.
- **`Esc`** abre pause menu (FOV slider, sensibilidade, volume, qualidade gráfica, salvar, sair).

---

## ⚔ Modo Sobrevivência

Aperte `G` no Criativo pra entrar em Sobrevivência — gravidade, fome, mobs hostis, e drop ao morrer.

### 1. Coletar madeira

- Encontre uma árvore.
- Olhe pro tronco e segure clique esquerdo até quebrar (~0.5s).
- Junte 4-6 toras.
- Quando quebrar, **folhas adjacentes começam a decair** em 0.2-3s (paridade Minecraft).

### 2. Workbench

- Aperte **C** pra abrir Crafting.
- Receitas base (sem workbench):
  - Madeira → 4× Pranchas
  - 2× Pranchas → 4× Paus
  - 4× Pranchas → 1× **Workbench**
- Coloque o workbench (right-click com workbench selecionado).
- Fique perto dele — receitas avançadas aparecem.

### 3. Picaretas e mineração

| Tier | Receita | Desbloqueia |
|------|---------|-------------|
| Madeira | 3 prancha + 2 pau | Pedra, Carvão |
| Pedra | 3 pedra + 2 pau | Ferro |
| Ferro | 3 lingote ferro + 2 pau | Ouro, Diamante |
| Diamante | 3 diamante + 2 pau | Obsidiana |

**Drops especiais ao quebrar pedra** (Sprint 3+9):
- 2% chance de Lápis Lazuli (necessário pra encantar)
- 10% chance de Sílex (necessário pra isqueiro do portal Nether)

### 4. Fornalha

- 8× Pedra → **Fornalha**.
- Right-click → painel com **Item** + **Combustível** = Saída.
- 1 ferro bruto + 1 carvão → 1 lingote.
- 1 carne crua + 1 carvão → carne cozida (8 fome em vez de 3).

### 5. Comida e fome (Sprint 1 — hunger curve real)

- Mate vaca/galinha/porco (`F`) → carne crua.
- Coma com `Q`.
- **Cozinhe primeiro** (carne crua tem 15% chance de envenenar).
- **Hunger curve real** (Sprint 1):
  - Exhaustion acumula por sprintar (0.10/s) e andar (0.01/s).
  - A cada 4 exhaustion, drena 1 saturation (depois 1 fome).
  - Regen rápido: fome ≥18 + saturation > 0 → +1 HP / 0.5s.
  - Regen lento: fome ≥18 + sem dano há 4s → +1 HP / 4s.
  - Sem comida (fome=0): -1 HP a cada 4s (até HP 1).

### 6. Mobs hostis (luz ≤ 7)

Hostis spawnam em luz baixa: à noite, em cavernas, em qualquer canto sem tochas.

| Mob | HP | Dano | Drops | Estratégia |
|-----|----|------|-------|------------|
| 🧟 Zumbi | 16 | 2 | Carne podre | **Queima ao sol** — bata e recue até amanhecer |
| 💀 Esqueleto | 14 | 2 | Osso (60%) + Flecha (40%) | **Atira flecha** — feche distância ou se esconda |
| 🕷 Aranha | 12 | 3 | Lã (50%) | Mais rápida — fuja se HP baixo |
| 💥 Creeper | 10 | 8 explosão | Carvão (50%) | **Fuse 1.5s antes de explodir** — corra! Foge se cat <6 blocos. |
| 🟢 Slime | 8 | 2 | Lã | **Split em 2-3 menores ao morrer** — atinja entre pulos |
| 🟣 Enderman | 20 | 3 | Diamante (50%) | **Teleporta** — persistente, evite |
| 🧙 Witch | 18 | 3 | Lápis (50%) + Poção heal (30%) | **Atira poção à distância** (alcance 8) |
| 👻 Ghast (Nether) | 14 | 5 | Ouro 1-2 | Flutua — atire flechas |

**🐺 Lobo** é amigável: domesticável com **Osso** (drop de esqueleto). Domesticado segue você + ataca hostis num raio de 16 blocos. Mostra **colar vermelho** quando domesticado.

**🐈 Cat** é amigável: domesticável com **Peixe** (drop de cat). **Creeper foge se cat <6 blocos** — gato é defesa anti-creeper.

**🤖 Iron Golem** spawn raro (1.5%) em planicies/floresta dia. HP 60. Ataca hostis automaticamente. Drops 3-5 ferro.

**🧑 Villager** spawn raro (3%) em planicies/floresta. **Right-click abre painel de TRADE** com 4 trocas estáveis (mesma posição = mesmas trocas):
- 5 trigo → 1 esmeralda
- 3 carne cozida → 1 esmeralda
- 1 esmeralda → 5 pão
- 1 esmeralda → 1 livro
- 5 esmeraldas → 1 diamante (raro)

**Vilas geradas** (Sprint 7): 1% chance por chunk — 3 casas com porta + 3 villagers spawnados automaticamente.

### 7. Iluminação anti-mob (Sprint 5)

**Hostis NÃO spawnam se há luz block ≥8 num cubo 3×2×3** ao redor — paridade Minecraft real:
- **Tocha** (luz 13): receita 1 carvão + 1 pau → 4 tochas. Coloque a cada 8-10 blocos pra cobertura.
- **Glowstone/Luz** (luz 14): drop natural no Nether teto.

### 8. Armadura (workbench)

| Tier | Material | Defesa total |
|------|----------|--------------|
| Couro | 24× couro | 7 pontos (28% redução) |
| Ferro | 24× ferro | 15 pontos (60%) |
| Diamante | 24× diamante | 21 pontos (80% — máx) |

Equipe pelo painel `E` (clique no slot da armadura).

### 9. Cama, dormir e save

- 3× Lã + 3× Pranchas → **Cama**.
- À noite, right-click → pula pro amanhecer + restaura HP.
- **Autosave** a cada 30s. Salvar manual: pause menu → Salvar Mundo.
- Save persiste em `localStorage` por mundo nomeado.

### 10. Baú

- 8× Pranchas → **Baú** (27 slots).
- Right-click → painel de troca.

### 11. Submerso

- Submerso = barra **🫧 ar** com 10 bolhas.
- Vazio: -2 HP/s.
- Nadar: `Espaço` sobe; movimento lento debaixo.
- Mobs **flutuam** na água (Sprint 6) — não afundam mais.

---

## 🌱 Farming (Sprint 1)

### Trigo
1. Quebre grama várias vezes — **15% chance de soltar Sementes**.
2. Right-click sementes em terra/grama → planta (toast: "Muda plantada").
3. Aguarde **30s** → matura (toast: "🌾 N planta(s) madura(s)") + drops automáticos no chão.
4. Drops por planta: **1 trigo + 1-3 sementes** (renovável!).
5. **Receita**: 3 trigo → **1 pão** (nutrição 5).

### Árvores renovadas
1. Quebre folha — **6% chance de soltar Muda de Carvalho**.
2. Right-click muda em grama → planta (toast: "Muda plantada — vai crescer em ~20s").
3. Aguarde 15-25s → vira árvore completa (tronco 4-8 + copa esférica).

### Dirt → Grass spread
- Terra exposta com grama vizinha **vira grama lentamente** (Sprint 5, tickado a cada 5s).
- Restaura áreas mineradas naturalmente.

---

## 💎 Encantamentos (Sprint 3 — endgame)

### 1. Conseguir Lápis Lazuli
- Mine pedra. **2% chance** de soltar 1 Lápis.

### 2. Crafte a Mesa de Encantamento
- 1× Livro (3 pranchas + 1 lã)
- 2× Diamante
- 4× Obsidiana (água+lava → obsidiana, picareta de diamante quebra)
- → **Mesa de Encantamento** (emite luz 7).

### 3. Encantar
- Selecione um item (espada, picareta, ou peça de armadura).
- Right-click na mesa.
- Custo: **10/20/30 XP + 1 LAPIS** por nível 1/2/3.
- Tipo do enchant é automático pelo item:
  - Espada → **Sharpness** (+1/+2/+3 dano)
  - Picareta → **Efficiency** (+20%/+40%/+60% velocidade)
  - Armadura → **Protection** (-5%/-10%/-15% dano por peça)

### Combo endgame
- Espada de ferro + Sharpness 3 + Poção de Strength = quase OHKO em zumbi.
- Picareta de diamante + Efficiency 3 = mineira pedra em ~1.6× velocidade.
- 4 peças de armadura ferro + Protection em todas = -50% dano total.

---

## 🧪 Poções (Sprint 3)

Crafting na bancada:
- **Heal**: água + lapis + 1 ouro → +5 HP instantâneo.
- **Speed**: água + lapis + 2 paus → +30% velocidade por 30s.
- **Strength**: água + lapis + 2 ferro → +50% dano em ataques por 30s.
- **Regen**: água + lapis + 2 trigo → +1 HP a cada 1.5s por 30s.

Beba com **Q** (igual comer).

---

## 🔥 Nether Dimension (Sprint 9)

### Como acessar

1. Mine 4+ obsidiana (use água + lava + picareta de diamante).
2. Mine pedra até dropar **Sílex** (10% chance).
3. Crafte **Isqueiro** (1 ferro + 1 sílex na bancada).
4. **Right-click no bloco de obsidiana com isqueiro selecionado** → vira PORTAL_NETHER (swirl roxo emissivo).
5. **Pise no portal por 1.5s** → 🔥 Bem-vindo ao Nether!

### O que tem no Nether

- **Netherrack** (vermelho) por todo terreno — mineira fácil.
- **Cavernas Perlin agressivas** com lava lakes (30% chance em y<10).
- **Glowstone (LUZ)** clusters no teto (y=58, 3% por bloco) — emite luz 14.
- **Bedrock** floor (y=0-2) e ceiling (y=62+).
- **Ghast** (único mob): flying tank HP 14, dano 5, drops 1-2 ouro.

### Voltar pro Overworld

- Encontre o portal de volta (mesmo bloco de portal).
- Pise nele 1.5s → 🌍 De volta ao Overworld.
- Sua posição no overworld é mantida.

---

## 🌐 Multiplayer (Sprint 8 + 8.5)

### Online (cross-device — qualquer dispositivo, qualquer rede)

1. Clique **👥 Multiplayer** no boot screen.
2. Digite **nome da sala** (ex: `meu-grupo-amigos`).
3. Clique **🌐 Conectar online**.
4. Mande o nome da sala pro amigo.
5. Ambos digitam o mesmo nome → conectam → vêem um ao outro como humanóides com nome flutuante!

### Local (mesma máquina, abas diferentes)

- Abra o jogo em **2+ abas** do mesmo browser.
- Cada aba pode usar nome diferente.
- Outros aparecem automaticamente como ghost players.

### Compartilhar mundo (export/import)

- Modal Multiplayer → **⬇ Exportar mundo** baixa JSON.
- Mande pro amigo via Discord/WhatsApp.
- Amigo abre modal → **⬆ Importar mundo** → seleciona JSON.
- Amigo joga **seu** mundo (seed + chunks modificados).

### Limitações

- Sync é **só visual** (posição+rotação+nome).
- Chunks/blocos quebrados **não** se sincronizam — cada player joga seu próprio mundo simultaneamente.

---

## 🎯 Atalhos profissionais

- **Hotbar swap**: scroll do mouse rola entre 9 slots.
- **Sneak (`Ctrl`)**: agacha + impede cair de borda — pra construir em pontes.
- **Critical hit**: ataque enquanto cai → 1.5× dano + som especial + 7 estrelas amarelas (Sprint 4).
- **Sprint dust**: poeira marrom atrás dos pés ao correr (Sprint 4).
- **XP orbs**: ao matar mob/minerar, esferas verdes voam pra você num raio de 5m.
- **Quebrar segurando**: 5 estágios de rachaduras crescentes.
- **F3**: stats globais persistidas (mobs killed, blocos quebrados, mortes, minutos jogados, faces meshadas, players online).

---

## 🏗 Building avançado (Sprint 2)

- **Lajes** (slab pedra/madeira/tijolo) — meia altura, perfeito pra escadas naturais ou cobertura.
- **Cerca de madeira** — pillar central 0.4×1.0×0.4, passa nos cantos mas bloqueia centro.
- **Escada (ladder)** — chapinha vertical, **ativa climb mode** (sobe/desce com Espaço/W).
- **Porta** — toggleable: right-click abre/fecha. Door fechada bloqueia faixa Z; aberta passa.

Receitas:
- Lajes: 3 do bloco base → 6 lajes (workbench).
- Cerca: 4 pranchas + 2 paus → 3 cercas.
- Ladder: 7 paus → 3.
- Porta: 6 pranchas → 1.

---

## ⚙️ Configurações (pause menu — `Esc`)

- **FOV slider** (50-110): mais largo = mais campo de visão, menos detalhe.
- **Sensibilidade do mouse** (5-60): ajusta velocidade de rotação da câmera.
- **Volume geral** (0-100%): master volume de todos os SFX + música.
- **Qualidade gráfica**: Auto / Baixa / Média / Alta / Ultra.
  - **Auto** detecta seu dispositivo (mobile baixo → low; iMac M1 → ultra).
  - Manual fixa o tier (escolha menor pra mais FPS, maior pra mais bonito).

---

## 🏆 Achievements (Sprint 4)

12 conquistas desbloqueadas conforme você joga:
- 🪵 **Conseguindo Madeira** — quebre seu primeiro bloco de madeira
- 🟫 **Conseguindo Pranchas** — crafte pranchas
- ⛏ **Tempo Para a Mineração** — crie uma picareta
- 🪨 **Era da Pedra** — quebre seu primeiro bloco de pedra
- 💎 **Diamantes!** — minere um diamante
- 🔥 **Aceso** — crie uma fornalha
- 🍖 **Hora do Almoço** — coma carne cozida
- ⚔ **Monsterhunter** — derrote seu primeiro mob hostil
- 📦 **Acumulador** — crie um baú
- 🌱 **Reflorestador** — plante uma muda
- 🐺 **Melhor Amigo do Homem** — domestique um lobo
- 🏚 **Profundezas** — encontre uma dungeon

Toast verde grande slide-in da direita. Persistido em localStorage.

---

## 💾 Save

- **Multi-mundo** (Sprint 8): cada mundo tem nome próprio + seed.
- Boot screen lista todos os mundos salvos com data da última sessão.
- Pode excluir mundos individualmente (✕ vermelho).
- **Autosave** a cada 30 segundos.
- **Salvar manual**: pause menu → Salvar Mundo.
- Tudo em `localStorage` do browser (até 12 mundos).

---

## ❓ Problemas comuns

| Problema | Solução |
|----------|---------|
| Mouse não trava | Clique no canvas; alguns browsers exigem fullscreen ou HTTPS. |
| Sem som | Toque a tela uma vez no celular (iOS exige gesto pra desbloquear AudioContext). |
| FPS baixo | Pause menu → Qualidade → "Baixa" ou "Auto". Adaptive monitor já reduz tier se cair < 28fps por 2s. |
| Travamento longo | Loading overlay aparece automaticamente quando há muito chunk pendente. Aguarde. Memory watchdog libera chunks distantes se >85% RAM. |
| Mundo travado | `Esc` → "Sair" → re-entre. |
| Save corrompido | DevTools → Application → Local Storage → exclua `rebcm3d_world_<nome>`. |
| Multiplayer não conecta | Verifique nome da sala; servidor é `wss://construcao-criativa-mp.rebcm-mp.workers.dev`. SSL pode demorar 10min em primeiro acesso. |
| Não vê outros players | Confirme nome da sala IDÊNTICO entre vocês. Toast "🌐 Conectado à sala 'X'" deve aparecer. |

---

*Diversão sem limites. Boas construções!* 🧱✨

*Atualizado em maio/2026 — pós sprint 9 (Nether) + 8.5 (multiplayer cross-device).*
