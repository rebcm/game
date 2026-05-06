# 🧱 Construção Criativa da Rebeca — 3D

> Jogo voxel 3D inspirado em Minecraft, rodando 100% no navegador. Mundo infinito por chunks, modos Criativo e Sobrevivência, mobs, crafting, fornalha, baú, ciclo dia/noite, iluminação 15 níveis, mob spawn por luz e muito mais.

**🎮 [JOGAR AGORA](https://construcao-criativa.pages.dev)**

**Autora:** Rebeca Alves Moreira

---

## ✨ Características

- ✅ **3D puro** com Three.js + WebGL (sem Flutter, sem build step).
- ✅ **Mundo infinito** com chunks 16×16×64 carregados sob demanda.
- ✅ **26 blocos** todos opacos (sem transparência) para máxima fidelidade visual ao Minecraft.
- ✅ **11 mobs** com IA (vaca, galinha, porco, ovelha, lobo, zumbi, esqueleto, aranha, creeper, slime, enderman).
- ✅ **Iluminação 15 níveis** (skylight + blocklight com flood-fill BFS).
- ✅ **Modos Criativo + Sobrevivência** alternáveis com `G`.
- ✅ **Crafting completo** com 25+ receitas, workbench, fornalha, baú, cama.
- ✅ **HUD pixel-perfect** com fonte Press Start 2P, vinheta, flash dano, heart shake.
- ✅ **Áudio procedural** via Web Audio: passos por material, mob sounds, ambient cave/wind, música em loop.
- ✅ **Save automático** em localStorage (a cada 30s).
- ✅ **Mobile-friendly** com joystick virtual e botões touch.

---

## 🚀 Como Jogar

Acesse **[https://construcao-criativa.pages.dev](https://construcao-criativa.pages.dev)** no navegador. Funciona em desktop, tablet e celular.

### Controles desktop

| Tecla | Ação |
|-------|------|
| `Mouse` | Olhar (pointer lock) |
| `W A S D` | Mover |
| `Espaço` | Pular / subir (Criativo) / nadar para cima |
| `Shift` | Sprintar (Sobrevivência) / descer (Criativo) |
| `Ctrl` | Agachar (impede cair de borda) |
| `Click esq.` | Quebrar bloco (segurar para quebra progressiva) |
| `Click dir.` | Colocar bloco / interagir |
| `Scroll` ou `1`–`9` | Trocar slot da hotbar |
| `E` | Inventário (Criativo: abas + busca) |
| `C` | Painel de crafting |
| `F` | Atacar mob mais próximo |
| `Q` | Comer item da hotbar |
| `G` | Alternar Criativo / Sobrevivência |
| `F5` | Trocar 1ª / 3ª pessoa |
| `F3` | Tela de debug |
| `F1` | Esconder / mostrar HUD |
| `Esc` | Pausar |

### Controles mobile

Joystick virtual à esquerda, drag à direita pra olhar, botões de pular/quebrar/colocar/atacar/descer.

---

## 🏗️ Arquitetura

O projeto é **inteiramente modular**: cada sistema é um arquivo `.js` em [`web3d/src/`](web3d/src/).

```
web3d/
├── index.html              # HUD + áudio inline
├── style.css               # Estilo pixel-perfect
├── manifest.json           # PWA
├── _headers                # Cloudflare Pages cache headers
└── src/
    ├── main.js             # Entry point: init() + loop
    ├── state.js            # Estado global compartilhado
    ├── constants.js        # BLOCO, ITEM, RECEITAS, dimensões
    ├── utils.js            # Hashes, AO, materialDeBloco, uvCelula
    ├── audio.js            # Wrapper sobre window.rebcm.sfx
    ├── world.js            # Chunk + World + lighting 15 níveis
    ├── render.js           # Renderer Three.js + atlas + sky + mesh builder
    ├── player.js           # Player + física AABB + swim/sneak
    ├── inventory.js        # Inventario + Drops + Crafting
    ├── mobs.js             # Mob, MobManager, 11 espécies, spawn por luz
    ├── particles.js        # Partículas, ItemDrop, XPOrb, ambient triggers
    ├── ui.js               # UI: HUD, paineis, F3, pause, criativo, tooltip
    ├── save.js             # localStorage (schema v4)
    └── input.js            # Keyboard + mouse + touch
```

A documentação detalhada de cada módulo está em [`docs/MODULES.md`](docs/MODULES.md).

---

## 🤖 Manutenção por IA (Claude Code, Cursor, Copilot)

Este projeto foi **estruturado especificamente para ser mantido e evoluído por agentes de IA** em modo auto-continue. Veja [`CLAUDE.md`](CLAUDE.md) para instruções de como qualquer agente deve trabalhar no código.

**Resumo:**
- Cada módulo é independente e pequeno (50–500 linhas).
- Sem build step — edição direta dos arquivos `.js` recarrega o jogo.
- Smoke tests em [`scripts/test-web3d-precheck.js`](scripts/test-web3d-precheck.js) validam invariantes.
- Deploy automático via [`scripts/deploy-web3d.sh`](scripts/deploy-web3d.sh) com cache busting.

---

## 🚀 Rodar localmente

```bash
git clone https://github.com/rebcm/game
cd game/web3d

# Servidor estático (qualquer um funciona)
python3 -m http.server 8000
# Acesse http://localhost:8000
```

ES modules exigem HTTP — não use `file://`.

---

## ☁ Deploy

```bash
# .env precisa ter CLOUDFLARE_API_TOKEN e CLOUDFLARE_ACCOUNT_ID
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

O script:
1. Copia `web3d/` para tmp.
2. Substitui `__BUILD_VERSION__` pelo timestamp UTC (cache busting).
3. Valida sintaxe de todos os módulos (`node --check`).
4. Roda 93 smoke tests (`scripts/test-web3d-precheck.js`).
5. Publica via `wrangler pages deploy` no projeto `construcao-criativa`.

A cada push em `main`, o GitHub Actions executa o mesmo script.

---

## 📜 Filosofia

1. **Modular para IA.** Cada sistema vive num arquivo só, com responsabilidade clara.
2. **Sem transparência.** Todos os blocos são opacos — paridade visual com o Minecraft real.
3. **Sem build step.** Edita JS, recarrega, funciona. Sem Webpack/Vite/transpilers.
4. **Mobile-first.** 60 fps em celular médio em modo paisagem.
5. **Pixel-perfect Minecraft.** 15 níveis de luz, 20 HP, 20 fome, 64 stack, 4 tiers de ferramenta.
6. **Autoria preservada.** Rebeca Alves Moreira em todos os documentos relevantes.

---

## 📚 Documentação

- [`README.md`](README.md) — você está aqui
- [`CLAUDE.md`](CLAUDE.md) — instruções de auto-continue para Claude Code
- [`AGENTS.md`](AGENTS.md) — regras detalhadas para qualquer agente de IA
- [`ARCHITECTURE.md`](ARCHITECTURE.md) — arquitetura técnica
- [`docs/MODULES.md`](docs/MODULES.md) — referência módulo por módulo
- [`docs/walkthrough.md`](docs/walkthrough.md) — passo-a-passo do jogo
- [`docs/SETUP.md`](docs/SETUP.md) — setup de desenvolvimento

---

## 🏆 Créditos

**Autora e personagem principal:** **Rebeca Alves Moreira**

**Tecnologias:**
- [Three.js](https://threejs.org/) (BSD-3) — engine 3D WebGL
- [Cloudflare Pages](https://pages.cloudflare.com) — hospedagem

Inspirado em jogos voxel sandbox. Projeto educacional independente, sem afiliação com Mojang.

---

*"Construa mundos. Não há limites."* 🧱✨
