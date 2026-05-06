# 🧱 Catálogo de Blocos

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira
**Versão:** Web3D (Three.js)

Lista completa dos 26 tipos de bloco do jogo, agrupados por categoria. Os IDs vêm de `BLOCO` em [`../../web3d/game.js`](../../web3d/game.js).

---

## 🏗 Construção

| ID | Nome | Cor | Notas |
|----|------|-----|-------|
| 1 | Grama | Verde | Topo de morros e planícies |
| 2 | Terra | Marrom | Camadas abaixo da grama |
| 3 | Pedra | Cinza | Rocha base — precisa de picareta tier 1+ |
| 4 | Areia | Amarelo | Praias, vales e desertos |
| 5 | Madeira | Bege | Tronco de árvore |
| 7 | Tijolo | Vermelho | Bloco clássico de construção |
| 12 | Neve | Branco | Topo de montanhas |
| 25 | Bedrock | Cinza-escuro | **Indestrutível** — três camadas no fundo |

## 🌿 Natureza

| ID | Nome | Notas |
|----|------|-------|
| 6 | Folha | Drop raro de pau (5%); semitransparente |
| 15 | Cacto | Causa 1 de dano ao tocar |

## 💎 Minérios e metais

| ID | Nome | Tier mínimo | Notas |
|----|------|-------------|-------|
| 13 | Carvão | 1 (madeira) | Combustível para fornalha |
| 14 | Ferro | 2 (pedra) | Funde para lingote |
| 9 | Ouro | 3 (ferro) | Decorativo + crafting de ferramentas |
| 10 | Diamante | 3 (ferro) | Tier máximo de ferramenta |
| 18 | Obsidiana | 4 (diamante) | Bloco mais resistente do jogo |

## 💧 Líquidos

| ID | Nome | Notas |
|----|------|-------|
| 16 | Água | Permite swim; submerge cabeça → bolhas/afogamento |
| 17 | Lava | 3 dano a cada 0.5s; emite luz 15 |

## 🪟 Decoração e iluminação

| ID | Nome | Notas |
|----|------|-------|
| 8 | Vidro | Translúcido; não dropa ao quebrar |
| 11 | Luz | Emite luz nível 14 — sem necessidade de tocha |
| 20 | Lã | Drop de ovelha; ingrediente da cama |
| 21 | Tocha | Emite luz 13; afixada no chão |
| 24 | Cama | Pula a noite quando você dorme |

## ⚒ Funcionais

| ID | Nome | Receita | Função |
|----|------|---------|--------|
| 19 | Workbench | 4× Pranchas | Habilita receitas avançadas se está perto |
| 22 | Baú | 8× Pranchas | 27 slots de armazenamento |
| 23 | Fornalha | 8× Pedra | Cozinha comida e funde minérios |

---

## 🎨 Texturas

Todas as texturas são **geradas proceduralmente** em runtime numa canvas 512×256 (atlas único). Não há arquivos PNG no repositório — as texturas são desenhadas com `ctx.fillRect` em padrões pixelados estilo Minecraft. Veja `criarAtlasTexturas()` em [`../../web3d/game.js`](../../web3d/game.js).

## 💡 Iluminação

Blocos com `emiteLuz > 0` em `BLOCO_INFO`:

| Bloco | Nível |
|-------|-------|
| Lava | 15 (máximo) |
| Luz | 14 |
| Tocha | 13 |

A iluminação **não é flood-fill por voxel** (paridade Minecraft real ainda não está implementada). Em vez disso, blocos emissivos têm:
- Material com `emissive` no ColorRamp.
- `PointLight` nativo do Three.js para os blocos próximos do player (até 8 simultâneos).

## 📊 Categorias no Inventário Criativo

O painel Criativo (tecla `E` em modo criativo) classifica os blocos em 8 abas — veja `_categoriaItem()` em `game.js`:

- 🧱 Construção
- 🌿 Natureza
- 💎 Minérios
- 💧 Líquidos
- 🪟 Decoração
- ⛏ Ferramentas
- ⚔ Combate
- 🍖 Comida

---

*Atualizado em maio/2026 para refletir a versão Web3D.*
