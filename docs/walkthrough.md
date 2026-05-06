# 🎮 Walkthrough — Construção Criativa da Rebeca

**Autora:** Rebeca Alves Moreira
**Versão:** Web3D (Three.js)

Este é o passo-a-passo para começar a jogar e dominar todas as mecânicas.

---

## 🚪 Primeira Vez

1. Acesse https://construcao-criativa.pages.dev em qualquer navegador moderno.
2. Clique em **JOGAR EM TELA CHEIA** — o jogo entra em fullscreen + pointer lock no desktop, ou inicia em paisagem no celular.
3. Você nasce no Modo Criativo, voando, com hotbar pré-preenchida (grama, terra, pedra, madeira, vidro, neve, luz, tocha, picareta de madeira).

---

## 🦅 Modo Criativo (padrão)

Para construir livremente sem se preocupar com sobrevivência:

1. **Voe** com `Espaço` (subir) e `Shift` (descer).
2. **Selecione bloco** com scroll do mouse ou teclas `1`–`9`.
3. **Coloque bloco** com clique direito.
4. **Quebre bloco** com clique esquerdo (instantâneo no Criativo).
5. **`E`** abre o **Inventário Criativo** com 8 abas e busca:
   - 🧱 **Construção**: tijolo, pedra, madeira
   - 🌿 **Natureza**: grama, terra, areia, folha, cacto, neve
   - 💎 **Minérios**: carvão, ferro, ouro, diamante, obsidiana
   - 💧 **Líquidos**: água, lava
   - 🪟 **Decoração**: vidro, lã, tocha, cama, luz, workbench, baú, fornalha
   - ⛏ **Ferramentas**: picaretas (4 tiers)
   - ⚔ **Combate**: espadas + armaduras
   - 🍖 **Comida**: carne crua/cozida, ovo, etc.
6. Toque num item e ele substitui o slot ativo da hotbar com 64 unidades.
7. **`G`** alterna para Sobrevivência quando quiser desafio.

### Dicas de construção
- **`F5`** alterna 1ª/3ª pessoa — ótimo pra conferir a vista de fora.
- **`T`** alterna transparência: blocos como vidro/folha ficam opacos ou translúcidos.
- **`F3`** mostra coordenadas, chunk, bloco mirado, FPS — útil pra projetar grandes construções.
- **`Esc`** abre o pause menu (Voltar / Salvar / Modo / Sair).

---

## ⚔ Modo Sobrevivência

Aperte `G` no Criativo para entrar em Sobrevivência — agora a gravidade volta, fome aparece, e mobs hostis spawnam à noite.

### 1. Coletar madeira (1º minuto)
- Encontre uma árvore.
- Olhe para o tronco (madeira) e segure clique esquerdo até quebrar (~0.5s).
- Repita até pegar 4–6 toras.

### 2. Fabricar pranchas e workbench
- Aperte `C` para abrir o painel de Crafting.
- Madeira → 4× **Pranchas** (sem workbench).
- 4× Pranchas → 1× **Workbench**.
- Pranchas + 2 → 4× **Paus**.
- Coloque o workbench no chão (clique direito com workbench na hotbar).
- Fique perto dele — agora as receitas avançadas aparecem.

### 3. Picaretas e mineração
- 3× Pranchas + 2× Pau (no workbench) → **Picareta de madeira** (tier 1).
- Mine pedra → 3× Pedra + 2× Pau → **Picareta de pedra** (tier 2).
- Pedra de tier 2 desbloqueia **ferro**.
- Ferro derretido (na fornalha) + paus → **Picareta de ferro** (tier 3) → desbloqueia **ouro** e **diamante**.
- Diamante + paus → **Picareta de diamante** (tier 4) → desbloqueia **obsidiana**.

### 4. Fornalha
- 8× Pedra (no workbench) → **Fornalha**.
- Coloque a fornalha e clique direito nela.
- Slot **Item** = ferro bruto / carne crua. Slot **Combustível** = carvão / madeira. Saída automática.
- 1 ferro bruto + 1 carvão → 1 lingote de ferro.
- 1 carne crua + 1 carvão → 1 carne cozida (8 fome em vez de 3).

### 5. Comida e fome
- Mate uma vaca (`F`) → carne crua + couro.
- Coma com `Q` (carne crua: +3 fome, mas 15% de chance de envenenar).
- Cozinhe primeiro (carne cozida: +8 fome, sem risco).
- A barra **🍗 fome** começa em 20 e cai com sprint/pulo. Saturação esvazia primeiro.
- Quando fome ≥ 18 + sem dano há 4s + HP < 20: **regen automático**.

### 6. Mobs hostis (à noite)
Quando o sol abaixa (`F3` mostra "sun" decrescendo abaixo de 0.3):

| Mob | HP | Dano | Drops | Estratégia |
|-----|----|------|-------|------------|
| 🧟 Zumbi | 16 | 2 | Carne podre | Bata com espada e recue |
| 💀 Esqueleto | 14 | 2 | Pau | Tem alcance 6m — feche distância rápido |
| 🕷 Aranha | 12 | 3 | Lã | Mais rápida — fuja se HP baixo |
| 💥 Creeper | 10 | 8 (explosão) | Carvão | **Mate de longe ou fuja** — explode em proximidade |

**Lobo** (🐺) é amigável e ataca hostis automaticamente. Útil de aliado.

### 7. Armadura
No workbench:

| Tier | Material | Defesa total |
|------|----------|--------------|
| Couro | 24× couro (de vacas/porcos) | 7 pontos (28% redução) |
| Ferro | 24× ferro | 15 pontos (60% redução) |
| Diamante | 24× diamante | 21 pontos (80% redução, máx) |

Cada peça (cabeça/torso/pernas/botas) é um slot. Equipe pelo painel `E`.

### 8. Cama e dormir
- 3× Lã (de ovelhas) + 3× Pranchas → **Cama**.
- À noite, clique direito na cama → pula para o amanhecer.
- Restaura HP cheio.

### 9. Baú
- 8× Pranchas → **Baú** (27 slots de armazenamento).
- Clique direito no baú → painel de troca.

### 10. Submerso
- Quando você mergulha em água, a barra **🫧 ar** aparece com 10 bolhas.
- Cada bolha dura 1 segundo. Quando vazia: 2 dano por segundo (afogamento).
- Sair da água restaura 2 bolhas a cada 0.5s.

---

## 🏗 Construções Famosas pra Tentar

1. **Casa de tijolo** com janelas de vidro.
2. **Castelo de pedra** com torres e foço de água.
3. **Fazenda underground** iluminada com tochas.
4. **Templo dourado** todo de blocos de ouro.
5. **Estátua gigante da Rebeca** em pixel-art.

Coloque várias **tochas** (🕯) ou blocos de **luz** (💡) no escuro — eles iluminam a área ao redor por raio de 14–15 blocos, evitando spawn de mobs.

---

## 🎯 Atalhos Profissionais

- **Hotbar swap**: scroll do mouse rola entre os 9 slots sem tirar a mão.
- **Sneak (`Ctrl`)**: agacha + impede cair de borda — pra construir em pontes finas.
- **F3 + bloco mirado**: descobre o tipo exato do bloco em frente.
- **Quebrar segurando**: clique esquerdo segurado quebra com animação de 5 estágios (rachaduras crescentes).
- **`Q`**: come o item ativo da hotbar sem abrir inventário.

---

## 💾 Salvando

- **Autosave** acontece a cada 30 segundos.
- **`💾`** ou pause menu → "Salvar" → grava imediato.
- O save fica em `localStorage` do seu navegador. Trocou de browser? O mundo é novo.

---

## ❓ Problemas Comuns

| Problema | Solução |
|----------|---------|
| Mouse não trava | Clique no canvas; alguns browsers exigem fullscreen para pointer lock. |
| Sem som | Toque a tela uma vez no celular (iOS/Safari precisa de gesto). |
| FPS baixo | Diminua `VIEW_RADIUS` no `game.js` (de 4 para 3). |
| Mundo travado | Aperte `Esc` → "Sair" → "JOGAR" novamente. |
| Save corrompido | DevTools → Application → Local Storage → apague `rebcm3d_save_v1`. |

---

*Diversão sem limites. Boas construções!* 🧱✨
