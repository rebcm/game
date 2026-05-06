# 🌍 Geração do Mundo e Biomas

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira
**Versão:** Web3D (Three.js)

---

## 🗺 Visão Geral

O mundo da Construção Criativa é **infinito por chunks** (gerados sob demanda quando o player anda) e gerado de forma **determinística** a partir de uma `seed`.

A geração acontece em [`web3d/game.js`](../web3d/game.js) — função `World.gerarChunk(cx, cz)` na seção 3.

---

## 📦 Chunks

| Parâmetro | Valor |
|-----------|-------|
| Tamanho | 16 × 16 × 64 voxels |
| `VIEW_RADIUS` | 4 chunks ao redor do player |
| Total visível | ~81 chunks (9×9 grid) |

Cada chunk é uma `Uint8Array` de 16384 bytes (16 × 16 × 64). Cada byte = ID do bloco.

Chunks são carregados/descarregados conforme o player se move. Chunks **modificados** (player colocou/quebrou bloco) ficam em memória pra serem salvos.

---

## ⛰ Geração de Altura

A altura do terreno é calculada por **somatório de senoides em múltiplas frequências** (não Perlin/Simplex ainda — é uma melhoria pendente):

```javascript
v = sin(x·π) · cos(z·π) · 0.45        // ondas amplas
  + sin(x·2.5π) · sin(z·1.7π) · 0.30  // detalhe médio
  + sin(x·5.5π) · cos(z·3.5π) · 0.15  // detalhe fino
  + sin(x·8.5π) · sin(z·6.5π) · 0.10  // ruído alto
altura = 6 + floor((v+1)/2 · 18)       // range [6, 24]
```

Resultado: terreno suave com colinas e vales.

---

## 🏔 Biomas

Apesar de o jogo se chamar "criativo puro", a versão Web3D atual **diferencia 4 zonas visuais** baseadas em altitude e hash determinístico (`World.topoBioma`):

| Zona | Bloco de topo | Condição |
|------|---------------|----------|
| 🏖 **Praia / Deserto** | Areia | altura ≤ 4, ou faixa hash `(z - seed) % 256 < 76` |
| 🌳 **Planícies** | Grama | padrão (zona maior) |
| ❄ **Tundra / Pico** | Neve | altura ≥ 22, ou faixa hash `(z + seed) % 256 > 200` |
| ⛰ **Montanha** | Pedra | quando altura sobe muito |

Não são "biomas" do Minecraft real (com humidade/temperatura) — é um proxy visual leve.

---

## 🪨 Geologia (subsuperfície)

Da superfície pro fundo:

| Y (de cima pra baixo) | Bloco |
|-----------------------|-------|
| `h .. h-3` | Topo (grama / areia / neve) |
| `h-4 .. 5` | Pedra com minérios distribuídos |
| `4 .. 3` | Pedra com 14% de chance de **lava** |
| `2 .. 0` | **Bedrock** (indestrutível) |

### Distribuição de minérios

| Camada | Probabilidade | Minério |
|--------|---------------|---------|
| `y < 6` | 3% | 💎 Diamante |
| `y < 10` | 6% | 🥇 Ouro |
| `y < 14` | 14% | ⚙ Ferro |
| qualquer | 26% | ⬛ Carvão |

Hashing usa `hash3(x, y, z, seed XOR 0xa1b2)` — totalmente determinístico.

---

## 🕳 Cavernas

Cavernas são geradas por **ruído 3D pseudo-Simplex** (na verdade hash 3D + distância euclidiana, paridade visual aproximada).

- Densidade: ~3% dos voxels entre y=5 e y=50.
- Resultado: corredores irregulares conectando câmaras.
- Iluminação: completamente escuras se não houver lava perto. Carregue tochas!

---

## 🏘 Estruturas

Geradas após o terreno base, em probabilidade fixa por chunk:

### 🌳 Árvores
- **Local:** topo de blocos de grama.
- **Probabilidade:** ~5–8% por bloco de grama.
- **Geometria:** tronco vertical (madeira) altura 4–7 + copa esférica de folhas.

### 🌵 Cactos
- **Local:** topo de areia.
- **Probabilidade:** ~3% por bloco de areia.
- **Altura:** 1–3 blocos.
- Causam 1 de dano ao tocar (no Sobrevivência).

### 🏠 Cabanas
- **Probabilidade:** ~1.5% dos chunks.
- **Estrutura:** 5 × 5 × 5 com paredes de tijolo, workbench dentro, tochas iluminando.

### 🌋 Lava
- **Local:** y=3..4 com 14% de probabilidade.
- Forma poças irregulares no underground.

---

## 🌅 Ciclo Dia/Noite

Independente do mundo (não é parte da geração):

- `DIA_SEGUNDOS = 240` (4 minutos por dia completo).
- Variável `tempoDia` ∈ [0, 1] avança a cada frame.
- `sun = max(0.05, 0.5 + 0.5·sin(2π·tempoDia − π/2))` controla iluminação:
  - Pico em `tempoDia = 0.25` (meio-dia).
  - Mínimo em `tempoDia = 0.75` (meia-noite).
- **Sol** e **lua** orbitam num arco visível seguindo o player.
- **Nuvens** rolam num plano y=70 com textura procedural pixelada que escorrega lentamente em +X.
- **Cor do céu** interpola: noite (azul-escuro) → crepúsculo (laranja) → dia (azul-claro).

---

## 🚧 Limitações Atuais (vs Minecraft real)

- ❌ Não usa Perlin/Simplex puro (apenas senoides) — terreno parece "ondulado regular".
- ❌ Não há biomas reais com humidade/temperatura.
- ❌ Não há vilas com NPCs (apenas cabanas decorativas).
- ❌ Não há ravinas grandes ou dungeons com loot.
- ❌ Não há rios, oceanos, lagos verdadeiros (água é só ocasional).

Estes são **gaps conhecidos**, todos planejados para versões futuras. Veja [`../AGENTS.md`](../AGENTS.md) para a lista de melhorias autorizadas.

---

*Atualizado em maio/2026.*
