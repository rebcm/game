# 🎮 Walkthrough — Construção Criativa da Rebeca

**Autora:** Rebeca Alves Moreira

Guia passo-a-passo para começar a jogar e dominar todas as mecânicas.

---

## 🚪 Primeira vez

1. Acesse https://construcao-criativa.pages.dev
2. Clique **JOGAR EM TELA CHEIA** — o jogo entra em fullscreen + pointer lock no desktop, ou paisagem no celular.
3. Você nasce no Modo Criativo, voando, com hotbar pré-preenchida.

---

## 🦅 Modo Criativo (padrão)

Para construir livremente sem se preocupar com sobrevivência:

- **Voe** com `Espaço` (subir) e `Shift` (descer).
- **Selecione bloco** com scroll do mouse ou teclas `1`–`9`.
- **Coloque bloco** com clique direito.
- **Quebre bloco** com clique esquerdo (instantâneo no Criativo).
- **`E`** abre o **Inventário Criativo** com 8 abas + busca:
  - 🧱 Construção · 🌿 Natureza · 💎 Minérios · 💧 Líquidos
  - 🪟 Decoração · ⛏ Ferramentas · ⚔ Combate · 🍖 Comida
- Toque num item — substitui o slot ativo da hotbar com 64 unidades.
- **`G`** alterna para Sobrevivência.

### Dicas de construção
- **`F5`** alterna 1ª/3ª pessoa — confira a vista de fora.
- **`F3`** mostra coordenadas, chunk, bloco mirado, light level (sky/block), FPS.
- **`F1`** esconde o HUD para tirar screenshots limpas.
- **`Esc`** abre o pause menu (Voltar / Salvar / Modo / Sair).

---

## ⚔ Modo Sobrevivência

Aperte `G` no Criativo para entrar em Sobrevivência — gravidade, fome, mobs hostis.

### 1. Coletar madeira
- Encontre uma árvore.
- Olhe para o tronco (madeira) e segure clique esquerdo até quebrar (~0.5s).
- Junte 4–6 toras.

### 2. Workbench
- Aperte `C` para abrir Crafting.
- Madeira → 4× Pranchas (sem workbench).
- 4× Pranchas → 1× **Workbench**.
- 2× Pranchas → 4× Paus.
- Coloque o workbench (clique direito na hotbar com workbench selecionado).
- Fique perto dele — receitas avançadas aparecem.

### 3. Picaretas e mineração
| Tier | Receita | Desbloqueia |
|------|---------|-------------|
| Madeira | 3 prancha + 2 pau | Pedra, Carvão |
| Pedra | 3 pedra + 2 pau | Ferro |
| Ferro | 3 lingote ferro + 2 pau | Ouro, Diamante |
| Diamante | 3 diamante + 2 pau | Obsidiana |

### 4. Fornalha
- 8× Pedra → **Fornalha**.
- Slot **Item** + Slot **Combustível** = Saída.
- 1 ferro bruto + 1 carvão → 1 lingote.
- 1 carne crua + 1 carvão → carne cozida (8 fome em vez de 3).

### 5. Comida e fome
- Mate vaca/galinha/porco (`F`) → carne crua.
- Coma com `Q`.
- Cozinhe primeiro (carne crua tem 15% chance de envenenar).
- Fome ≥ 18 + sem dano há 4s = regen automático de HP.
- Saturação esvazia antes da fome (paridade Minecraft).

### 6. Mobs hostis (luz ≤ 7)

Hostis spawnam em luz baixa: à noite, em cavernas, em qualquer canto sem tochas.

| Mob | HP | Dano | Drops | Estratégia |
|-----|----|------|-------|------------|
| 🧟 Zumbi | 16 | 2 | Carne podre | Bata e recue |
| 💀 Esqueleto | 14 | 2 | Pau | Alcance 6m — feche distância |
| 🕷 Aranha | 12 | 3 | Lã | Mais rápida — fuja se HP baixo |
| 💥 Creeper | 10 | 8 (explosão) | Carvão | Mate de longe ou fuja |
| 🟢 Slime | 8 | 2 | Lã | Pula em arcos — atinja entre pulos |
| 🟣 Enderman | 20 | 3 | Diamante (50%) | Teleporta — persistente, evite |

🐺 **Lobo** é amigável e ataca hostis automaticamente.

**Dica:** ilumine cavernas com tochas (luz nível 13) ou blocos de luz (14) para impedir spawn.

### 7. Armadura (no workbench)

| Tier | Material | Defesa total |
|------|----------|--------------|
| Couro | 24× couro | 7 pontos (28% redução) |
| Ferro | 24× ferro | 15 pontos (60%) |
| Diamante | 24× diamante | 21 pontos (80% — máx) |

Equipe pelo painel `E` (clique no slot).

### 8. Cama e dormir
- 3× Lã + 3× Pranchas → **Cama**.
- À noite, clique direito → pula para o amanhecer + restaura HP.

### 9. Baú
- 8× Pranchas → **Baú** (27 slots).
- Clique direito → painel de troca.

### 10. Submerso
- Submerso = barra **🫧 ar** com 10 bolhas.
- Vazio: 2 dano por segundo.
- Nadar: `Espaço` sobe.

---

## 🎯 Atalhos profissionais

- **Hotbar swap**: scroll do mouse rola entre 9 slots.
- **Sneak (`Ctrl`)**: agacha + impede cair de borda — para construir em pontes.
- **Critical hit**: ataque enquanto cai → 1.5× dano + som especial.
- **XP orbs**: ao matar mob/minerar, esferas verdes voam para você a 5m.
- **Quebrar segurando**: 5 estágios de rachaduras crescentes.

---

## 💾 Save

- **Autosave** a cada 30 segundos.
- **`💾`** (ou pause menu → Salvar) → grava imediato.
- Save no `localStorage` do browser.

---

## ❓ Problemas comuns

| Problema | Solução |
|----------|---------|
| Mouse não trava | Clique no canvas; alguns browsers exigem fullscreen. |
| Sem som | Toque a tela uma vez no celular (iOS exige gesto). |
| FPS baixo | Diminua `VIEW_RADIUS` em `web3d/src/constants.js`. |
| Mundo travado | `Esc` → "Sair" → "JOGAR" novamente. |
| Save corrompido | DevTools → Application → Local Storage → apague `rebcm3d_save_v4`. |

---

*Diversão sem limites. Boas construções!* 🧱✨
