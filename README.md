<div align="center">

# 🧱 Construção Criativa da Rebeca — 3D

### *Voxel sandbox 3D inspirado em Minecraft, rodando 100% no navegador*

<br>

<a href="https://construcao-criativa.pages.dev">
  <img src="https://img.shields.io/badge/▶%20%20JOGAR%20AGORA%20%20—%20%20100%25%20FREE-4CAF50?style=for-the-badge&logoColor=white&labelColor=2E7D32&color=43A047" alt="JOGAR AGORA" height="120">
</a>

<br><br>

### 👉 [**construcao-criativa.pages.dev**](https://construcao-criativa.pages.dev) 👈

<br>

![status](https://img.shields.io/badge/status-em%20produção-success?style=flat-square)
![tests](https://img.shields.io/badge/smoke%20tests-124%2F124-brightgreen?style=flat-square)
![license](https://img.shields.io/badge/license-MIT-blue?style=flat-square)
![mobs](https://img.shields.io/badge/mobs-65-blue?style=flat-square)
![blocos](https://img.shields.io/badge/blocos-1000-orange?style=flat-square)
![items](https://img.shields.io/badge/items-210%2B-yellow?style=flat-square)
![dimensões](https://img.shields.io/badge/dimensões-3-purple?style=flat-square)
![estruturas](https://img.shields.io/badge/estruturas-14-red?style=flat-square)
![biomas](https://img.shields.io/badge/biomas-10-green?style=flat-square)

<br>

**1000 blocos · 210+ items · 65 mobs com IA · 60 encantamentos · 17 efeitos · 14 estruturas · 10 biomas · 15 profissões villager · Áudio 3D Spatial · Bloom + Sky Shader · Multiplayer cross-device**

**Autora:** Rebeca Alves Moreira

</div>

---

## 📚 Índice

- [✨ Por que jogar](#-por-que-jogar)
- [🎮 Como jogar](#-como-jogar)
- [⌨️ Controles](#️-controles-completos)
- [🌍 Conteúdo de jogo](#-conteúdo-de-jogo)
- [🎨 Qualidade gráfica premium](#-qualidade-gráfica-premium)
- [🔊 Áudio 3D Spatial](#-áudio-3d-spatial)
- [🌐 Multiplayer](#-multiplayer)
- [🤖 Sistemas adaptativos](#-sistemas-adaptativos)
- [🏛 Arquitetura](#-arquitetura)
- [🔧 Rodar local](#-rodar-local)
- [☁️ Deploy](#️-deploy)
- [📜 Histórico de sprints](#-histórico-de-sprints)
- [📚 Documentação](#-documentação)
- [🏆 Créditos](#-créditos)

---

## ✨ Por que jogar

> **TL;DR**: Voxel sandbox no browser com **paridade Minecraft 1.21** + **qualidade gráfica superior** (Bloom, Sky Shader, Vignette) + **áudio 3D HRTF binaural** + **64 achievements** + **multiplayer cross-device**.

| Categoria | O que tem |
|-----------|-----------|
| **🌐 Acesso** | 100% browser. Desktop, tablet, celular. Sem download, sem login, sem ads. |
| **🎨 Visual PREMIUM** | Sky shader gradient dinâmico, Bloom em emissive blocks, Vignette + Color Grading, ACES Filmic Tonemapping, 2 layers nuvens parallax, partículas ambientes (folhas caindo, faíscas, pollen), pixel ratio até 4×. |
| **🔊 Áudio 3D Spatial** | Web Audio API com HRTF binaural, distance attenuation inverse-square, reverb procedural, 6 ambient loops por bioma com LFO modulação. |
| **⚙️ Performance adaptiva** | Auto-detecta CPU/GPU/RAM e aplica preset (low/medium/high/ultra). Adaptive FPS monitor reduz qualidade se cair < 28fps. |
| **🌍 Mundo infinito** | Chunks 16×16×64 carregados sob demanda com **predictive load** (chunks na direção do movimento carregam primeiro). |
| **🌳 10 biomas vivos** | Deserto, Planícies, Floresta, Taiga, Cherry Grove, Mangrove Swamp, Bamboo Jungle, Mushroom Fields, Lush Caves, Snowy Plains/Taiga. |
| **🧟 65 mobs com IA** | A* pathfinding pra hostis melee, line-of-sight (não atacam através de paredes), spawn rules contextual, 4 bosses (Wither, Ender Dragon, Warden, Elder Guardian). |
| **⚔️ Combate avançado** | Bow charge, Crossbow Multishot, Trident Riptide (chuva), Mace Smash (1.21), Shield, Totem of Undying revive, Splash/Lingering potions. |
| **🏗️ Construção massiva** | **1000 blocos** premium com gradient + bevel + AO sutil. Slabs, escadas, paredes, fences, portas, trapdoors, signs editáveis, item frames. |
| **💎 Endgame profundo** | Mesa de Encantamento (60 encantamentos em 12 categorias), Brewing Stand, Beacon 4 tiers, Conduit Power, Smithing Table (netherite upgrade), Anvil. |
| **🌱 Farming completo** | 13 crops com growth stages 0-7 + hidratação + bonemeal, 8 árvores (oak/birch/spruce/jungle/acacia/dark_oak/cherry/mangrove). |
| **🐎 Mounts + Tame** | Wolf (osso), Cat (peixe), Parrot (semente), Horse/Donkey/Mule/Llama/Strider rideable. |
| **🪽 Voo Elytra** | Sprint+Jump no ar = glide, com Firework Boost para acelerar. |
| **👤 Villager Trading** | 15 profissões (farmer, butcher, fisherman, shepherd, fletcher, librarian, cleric, toolsmith, weaponsmith, armorer, leatherworker, mason, cartographer, nitwit, unemployed). |
| **🎯 14 estruturas geradas** | Vilas, Mineshafts, Dungeons, Stronghold, Nether Fortress, End City (com Elytra!), Ancient City, Trial Chamber (1.21), Ocean Monument, Pillager Outpost, Woodland Mansion. |
| **🏆 64 achievements** | Sistema completo paridade Minecraft (Combat, Materials, Crafting, Exploration, Sky, Survival, etc). |
| **🌐 Multiplayer real** | Cross-device via Cloudflare Worker + WebSocket (deployado e ativo) + local via BroadcastChannel. |
| **💾 Multi-save** | Vários mundos com nome + jogador identificado. Export/import JSON pra compartilhar. |

---

## 🎮 Como jogar

1. Acesse **[construcao-criativa.pages.dev](https://construcao-criativa.pages.dev)**
2. Digite seu nome e nome do mundo
3. Clique **▶ Jogar** (entra em fullscreen + pointer lock no desktop, paisagem no celular)
4. Pra jogar com amigo: clique **👥 Multiplayer** → escolha sala → mande o nome da sala pro amigo

### Primeira partida em 3 minutos

1. Quebre **árvores** (madeira) — F na hotbar pra usar machado
2. Crafte **pranchas** (1 madeira → 4 pranchas)
3. Crafte **workbench** (4 pranchas)
4. Coloque workbench, fique perto, abra **C** (crafting)
5. Crafte **picareta de madeira** (3 pranchas + 2 paus)
6. Mine **pedra** → upgrade pra picareta de pedra → ferro → diamante → **netherite**
7. À noite, **acenda tochas** (carvão + pau) pra impedir spawn de mobs hostis
8. Crafte **portal** com 4 obsidiana + isqueiro = **Nether**
9. No Nether, busque **Stronghold** com 12 Eyes of Ender = **End**
10. Mate **Ender Dragon** + invoque **Wither** com 4 soul sand + 3 wither skulls

---

## ⌨️ Controles completos

### Desktop

| Tecla | Ação |
|-------|------|
| `Mouse` | Olhar (pointer lock automático) |
| `W A S D` | Mover |
| `Espaço` | Pular / subir (Criativo) / nadar pra cima |
| `Shift` | Sprint (Sobrevivência) / descer (Criativo) |
| `Ctrl` | Agachar — impede cair de borda |
| `Click esq.` | Quebrar bloco (segurar = quebra progressiva com 5 estágios de cracks) |
| `Click dir.` | Colocar bloco / interagir (porta, baú, fornalha, cama, villager, mesa de encantamento, etc.) |
| `Scroll` ou `1`–`9` | Trocar slot da hotbar |
| `E` | Inventário (no Criativo: 8 abas + busca) |
| `C` | Painel de crafting |
| `F` | Atacar mob (segura pra carregar arco/crossbow) |
| `Q` | Comer item / beber poção / lançar splash potion |
| `G` | Alternar Criativo / Sobrevivência |
| `F1` | Esconder/mostrar HUD |
| `F2` | 📸 Screenshot (baixa PNG) |
| `F3` | Tela de debug (chunk, luz, bioma, stats persistidas, faces meshadas, players online) |
| `F5` | Trocar 1ª/3ª pessoa |
| `Tab` | Liberar mouse sem pausar |
| `Esc` | Pause menu (FOV slider, sensibilidade, volume, qualidade, salvar, sair) |

### Mobile

- **Joystick virtual** à esquerda
- **Drag à direita** pra olhar
- **Botões touch**: pular, quebrar, colocar, atacar, descer
- **HUD escala** automaticamente pra portrait/landscape

---

## 🌍 Conteúdo de jogo

### 🟫 Blocos (1000)

**Naturais (50+):** Grama, Terra, Pedra, Areia, Cascalho, Argila, Calcita, Tuff, Dripstone, Basalto, Magma, Soul Sand, Soul Soil, Mycelium, Moss Block, Rooted Dirt, Mud, Mud Bricks, etc.

**Madeiras (8 tipos completos):** Oak, Birch, Spruce, Jungle, Acacia, Dark Oak, Cherry (1.20), Mangrove (1.19) — cada uma com Log + Pranchas + Folhas + Slab + Escada + Fence + Porta + Trapdoor + Sign + Stripped variant.

**Minérios (15):** Carvão, Ferro, Ouro, Diamante, Lápis Lazuli, Esmeralda, Redstone, Cobre, Quartzo Nether, Ancient Debris/Netherite + Deepslate variants.

**Fluidos:** Água (escoa 4 blocos), Lava (escoa 2 blocos, queima madeira)

**Especiais:** Bedrock, Obsidiana, Crying Obsidiana, Vidro (16 cores), Tijolo, Lã (16 cores), Tocha (luz 13), Glowstone (15), Sea Lantern.

**Funcionais:** Workbench, Fornalha, Smoker, Blast Furnace, Baú, Ender Chest, Cama, Mesa de Encantamento, Anvil, Smithing Table, Stonecutter, Loom, Cartography Table, Brewing Stand, Composter, Lectern, Bell, Beacon, Conduit, Hopper, Dispenser, Dropper, Observer, Daylight Sensor, Note Block, Jukebox, Bookshelf.

**Redstone:** Repeater, Comparator, Piston, Sticky Piston, Lever, Buttons (4), Pressure Plates (4), Trapped Chest, Tripwire.

**Decorativos premium:** 16 Concretos, 16 Terracotas, 16 Glazed Terracotas, 9 Shulker Boxes, 17 Velas, 16 Bandeiras, Pinturas, Item Frames, Armor Stand, Vase, Decorated Pot.

**Variantes 1.21 Tricky Trials:** Tuff Bricks/Chiseled, Chiseled Copper, Copper Bulb, Copper Grate, Trial Spawner, Vault.

**Sculk family (1.19):** Sculk, Sculk Vein, Sculk Sensor, Calibrated Sculk Sensor, Sculk Catalyst, Sculk Shrieker, Reinforced Deepslate.

**Plantas (50+):** Trigo/Cenoura/Batata/Beterraba/Melancia/Abóbora/Bambu/Cana/Kelp + Sweet Berries, Glow Berries, Torchflower, Pitcher Plant (1.20), Cherry Petals, Pink Petals, Big Dripleaf, Hanging Roots, Spore Blossom, Cactus Flower (1.20), Vines, Twisting/Weeping Vines, Crimson/Warped Roots/Fungus.

**🎯 Bloco icônico #999 — TRONO 1000 BLOCOS!** Pintor dedicado: vermelho real + tijolos dourados + coroa central + texto "1000" gravado.

### 🧟 Mobs (65)

**Passivos (18):** Vaca, Galinha, Porco, Ovelha, Mooshroom, Camelo, Axolote, Raposa, Glow Squid, Bee, Sapo (3 variantes: temperate/warm/cold), Tartaruga, Papagaio, Coelho, Allay, Snow Golem, Iron Golem, Dolphin.

**Hostis Overworld (16):** Zumbi, Drowned, Husk, Esqueleto, Stray, Aranha, Cave Spider, Creeper, Slime, Enderman, Witch, Phantom, Pillager, Vindicator, Evoker, Vex.

**Hostis Nether (10):** Magma Cube, Blaze, Ghast, Piglin, Hoglin, Zoglin, Zombified Piglin, Strider, Endermite, Silverfish.

**Aquáticos (5):** Guardian, Elder Guardian, Squid, Glow Squid, Dolphin.

**Bosses (4):** 💀 **Wither** (200 HP, 3 cabeças, fireballs triplos), 🐉 **Ender Dragon** (100 HP, voa em órbita, heal por crystals), 🦴 **Warden** (500 HP, sonic boom IGNORA armor, blindness), Elder Guardian.

**Mounts (5):** Horse, Donkey, Mule, Llama, Strider (lava walker).

**Special:** Ravager, Shulker, Spider Jockey, Tadpole, Cat, Wolf, Bat, Goat, Panda, Villager (15 profissões), Wandering Trader.

### 💎 Encantamentos (60 em 12 categorias)

**Espada (9):** Sharpness, Knockback, Looting, Smite, Bane of Arthropods, Fire Aspect, Sweeping Edge, Mending, Unbreaking
**Picareta (5):** Efficiency, Fortune, Silk Touch, Unbreaking, Mending
**Pá/Machado (5+)**, **Arco (6):** Power, Punch, Flame, Infinity, Unbreaking, Mending
**Crossbow (4):** Multishot, Quick Charge, Piercing, Unbreaking
**Tridente (5):** Loyalty, Channeling, Riptide, Impaling, Unbreaking
**Mace 1.21 (5):** Density, Breach, Wind Burst, Smite, Unbreaking
**Capacete/Peitoral/Perneiras/Botas (7+ cada):** Protection, Fire/Blast/Projectile Protection, Respiration, Aqua Affinity, Thorns, Feather Falling, Depth Strider, Frost Walker, Soul Speed, Swift Sneak

### 🧪 Efeitos de Status (17)

Speed, Slowness, Poison, Regen, Strength, Weakness, Fire Resistance, Resistance, Slow Fall, Levitation, Invisibility, Night Vision, Water Breathing, Dolphin's Grace, Haste, Jump Boost, Absorption, Wither, Hunger Effect, Soul Speed, Conduit Power, Turtle Master, Glowing, Blindness, Nausea, Luck, Bad Omen.

### 🏘 Estruturas geradas (14)

- **Vilas** — 1% por chunk em planicies/floresta com villagers de 15 profissões
- **Mineshafts** — corredor 3×3 com rails + tochas + baús + cave spiders
- **Dungeons** — sala com baú + tochas + spawner
- **Stronghold** (~0.5%) — Mossy stone bricks + 12 Portal Frames (End Portal)
- **Nether Fortress** — Tijolo nether + Blaze Rod + Netherite loot
- **End City** — Purpur 8×12×8 + End Rod + **ELYTRA** loot!
- **Ancient City** (~0.4%) — Sculk + Deepslate Polido + Warden + Echo Shards
- **Trial Chamber** (1.21) — Tuff bricks + Trial Spawner + Vault + Mace loot
- **Ocean Monument** — Prismarine + Sea Lantern + Guardians
- **Pillager Outpost** — Dark oak + Pillagers + Crossbow loot
- **Woodland Mansion** — Gigante 14×10×14 + Evokers + Totem of Undying
- **Iceberg, Ravina, Igloo** — variações ambientais

### 🌱 Farming completo (13 crops)

Trigo, Cenoura, Batata, Beterraba, Melancia, Abóbora, Bambu, Cana-de-açúcar, Kelp, Sweet Berries, Glow Berries, Torchflower, Pitcher Plant.

- Growth stages 0-7 (paridade MC)
- Hidratação ±30% (água em raio 4 acelera)
- Bone meal: instant +1-3 stages
- Tilling: hoe converte grama/terra em farmland

### 🌳 Tree Growth (8 árvores)

Oak, Birch (cone), Spruce (cone), Jungle, Acacia (plana), Dark Oak (mega 2×2 + copa enorme), Cherry (rosa fofa larga), Mangrove (cresce em LAMA).

### 🌧 Weather avançado

- **Chuva** (~30% do tempo) com 60 partículas + ambient
- **Neve acumula** durante chuva em altitude ≥30 (taiga/snowy_plains)
- **Trovões** raros (20% por intervalo de 25s durante chuva)
- **Lightning strikes** atinge bloco aleatório em raio 40
  - Incendeia madeira/folhas
  - Player <4 blocos: 8 dano elétrico

### 🏆 Achievements (64 total)

Sistema completo de conquistas com persistência localStorage. Categorias:
- **Combat**: PRIMEIRO_MOB, ESMAGAR_PILLAGER, CHEFAO_WITHER, CHEFAO_WARDEN, KILL_BOSS
- **Materials**: COLECIONAR_OURO/FERRO/ESMERALDA/NETHERITE
- **Crafting**: PRIMEIRA_PICARETA, CRAFTAR_ESPADA, CRAFT_FULL_ARMOR, CRAFT_ALL_TOOLS
- **Exploration**: EXPLORE_OCEAN/MANSION/FORTRESS/ANCIENT/TRIAL/VILLAGE/DESERT
- **Tame**: DOMESTICAR_LOBO/GATO/PAPAGAIO, CRIAR_FAMILIA
- **1.21**: TRIAL_KEY_USE, WIND_CHARGE_USE, MACE_SMASH
- **Sky/Mining**: SKY_HIGH (100m), SKY_DEEP (-50), MINE_100/1000_BLOCKS
- **Especiais**: GANHO_BEACON, GANHO_CONDUIT, ELYTRA_VOO, TOTEM_REVIVE, END_GATEWAY, CHORUS_TELEPORT

---

## 🎨 Qualidade gráfica premium

### Sky Dome Shader Customizado
- **Skydome 380 raio** com shader GLSL gradient horizon→zenith
- **Sun position dinâmica** acompanha tempoDia
- **Bloom solar radial** via dot(viewDir, sunPos)
- **Cores dinâmicas**: Noite (preto-azul + violeta), Sunrise (laranja), Golden Hour (azul + dourado), Dia (azul claro)

### Post-Processing Pipeline
- **EffectComposer** com 4 passes: RenderPass + UnrealBloomPass + Vignette/Color Grading + OutputPass
- **UnrealBloom** (strength 0.55, radius 0.6, threshold 0.78) — glow REAL em emissive blocks
- **Vignette** + **Saturação 1.10** + **Contraste 1.05**
- **Tone Mapping** ACESFilmic + exposure 1.15

### Texturas Premium
- **pintarPremium**: gradient + ruído + bevel highlight/AO
- **pintarPedraPremium**: gradient 3-stop + variações + cracks naturais
- **pintarGemPremium**: 3-5 cristais losango brilhantes + sparkles
- **pintarMadeiraPremium**: gradient + grão vertical + nós (knots)
- **pintarFolhaPremium**: 3 camadas tonais + buracos depth
- **Glowstone radial** ULTRA brilhante (gera bloom REAL)
- **Lava 4-stop** fogo + bolhas brilhantes + sparkles brancos
- **Água** com sparkles solares + reflexos + ondas

### Atmosfera
- **2 layers nuvens parallax** com gradient radial soft
- **Estrelas twinkling** à noite
- **Fog dinâmico** com cor seguindo o céu
- **Vinheta low-HP** quando vida ≤4

### Particles ambientes
- 🍃 Pétalas caindo de árvores (cherry rosa, oak verde)
- ✨ Faíscas premium em tochas
- ❄ Flocos de neve em queda
- 💛 Polen amarelo de bee
- 💧 Cave drip ambient

### Selection 3D
- **Selection Cube outline** 12 edges sempre visível em qualquer luz
- Crosshair com glow + dot central + cores contextuais (vermelho mob, amarelo bloco)

---

## 🔊 Áudio 3D Spatial

**Web Audio API + HRTF binaural** para imersão real superior ao Minecraft:

### Spatial Audio
- **PannerNode HRTF** (Head-Related Transfer Function) — sons vêm da direção certa
- **Distance attenuation** inverse-square (não linear) — mais realista
- **Listener tracking** posição + forward + up vector da câmera
- **maxDistance 16 blocos** — skip silent sounds pra performance

### Reverb Procedural
- **ConvolverNode** com IR procedural gerado em runtime (sem files externos)
- **Reverb 1.8s decay** wet 0.18 mixed em paralelo
- Aplicado em todos os panners → sensação de espaço real

### Ambient Loops por Bioma (6 tracks)
| Bioma | Frequência | Tipo | Volume |
|-------|-----------|------|--------|
| **cave** | 80→60 Hz | sine | 0.18 (wind howl) |
| **ocean** | 200→150 Hz | triangle | 0.20 (waves) |
| **forest** | 320→380 Hz | sine | 0.10 (birds chirp) |
| **nether** | 50→100 Hz | sawtooth | 0.30 (dread bass) |
| **end** | 440→220 Hz | sine | 0.15 (ethereal pad) |
| **dungeon** | 100→80 Hz | square | 0.14 (mob ambient) |

Cada track:
- LFO 0.08 Hz modulando frequency (movimento natural)
- BiquadFilter lowpass 800Hz (suavidade)
- Fade-in 3s + fade-out 1.5s
- Auto-switch a cada 2s baseado em y/dimension/biome

### SFX rico
- 30+ sons procedurais (passos por superfície, mob calls, ambient cave/wind, UI)
- **Pitch variation** 0.95-1.05 cada som (naturalidade)
- Mob calls específicos por tipo (zumbi, esqueleto, vaca, ovelha, porco, galinha, lobo, slime, enderman, etc.)

---

## 🌐 Multiplayer

### Como entrar numa sala online (cross-device)

1. Clique **👥 Multiplayer** no boot screen
2. Digite **nome da sala** (ex: `meu-grupo`)
3. Clique **🌐 Conectar online**
4. Mande o nome da sala pro amigo
5. Ambos digitam o mesmo nome → conectam → vêem um ao outro

### Como funciona

- **Servidor**: Cloudflare Worker com Durable Object SQLite-backed em `construcao-criativa-mp.rebcm-mp.workers.dev`
- **Sync**: posição + rotação + nome a 5Hz via WebSocket
- **Local fallback**: BroadcastChannel sincroniza abas do mesmo browser (sem servidor)
- **Free tier**: 100k req/dia ≈ dezenas de jogadores simultâneos
- **Persistente**: room name fica salvo, reconecta automaticamente

### Limitações honestas

- Sync é **só visual** (posição + rotação + nome)
- Chunks/blocos quebrados **não** se sincronizam — cada player joga seu mundo
- Pra mundo compartilhado: use **Export/Import JSON** (envia save pro amigo via Discord/WhatsApp)

---

## 🤖 Sistemas adaptativos

### Quality auto-detection

Detecta na inicialização: `navigator.deviceMemory` + `hardwareConcurrency` + `WEBGL_debug_renderer_info` + mobile flag → score 1-12 → tier:

| Tier | viewRadius | pixelRatio | AA | maxMobs | particles | snow | bloom |
|------|------------|------------|----|---------|-----------|------|-------|
| **low** | 4 chunks | 1.0 | off | 8 | 60 | off | off |
| **medium** | 6 chunks | 1.5 | on | 14 | 120 | on | on |
| **high** | 8 chunks | 2.0 | on | 20 | 250 | on | on |
| **ultra** | 10 chunks | 4.0 | on | 30 | 500 | on | on |

### Adaptive FPS monitor

Coleta últimos 120 frames. Se média < 28 fps por amostra cheia + modo=auto → baixa 1 tier automaticamente (max 1 troca/8s anti-yo-yo).

### Memory watchdog

A cada 1s lê `performance.memory` (Chrome). Se usado/limite > 85% → libera chunks fora do view radius normal + toast informativo (max 1×/10s).

### Loading overlay

Detecta backlog de chunks (faltando + dirty pendentes) > 50% do view radius → mostra `Carregando cenário…` translúcido sem bloquear input.

### Predictive load

Chunks faltantes ordenados por (distância + alinhamento com vetor de velocidade). Player andando pra +X carrega chunks de +X primeiro — anti-pop-in durante movimento.

### Frame watchdog

Se dt > 50ms (< 20fps), pula trabalho não-essencial nesse frame (clima, ambient, tick de mudas). Recupera framerate antes de retomar.

---

## 🏛 Arquitetura

```
game/
├── README.md ← você está aqui
├── CLAUDE.md             # Instruções pra Claude Code auto-continue
├── AGENTS.md             # Regras detalhadas pra agentes
├── ARCHITECTURE.md       # Detalhes técnicos
├── .env                  # Cloudflare credentials (NÃO commitado)
├── .github/workflows/
│   └── deploy.yml        # CI/CD (push → deploy automático)
├── docs/
│   ├── MODULES.md        # Referência por módulo
│   ├── walkthrough.md    # Guia de jogabilidade
│   └── SETUP.md          # Setup de dev local
├── scripts/
│   ├── deploy-web3d.sh   # Deploy Cloudflare Pages
│   └── test-web3d-precheck.js  # 124 smoke tests
├── worker/                                ⭐ Multiplayer cross-device
│   ├── src/index.js      # Durable Object Room (WebSocket relay)
│   └── wrangler.toml     # SQLite-backed DO config
└── web3d/                                 ⭐ O JOGO
    ├── index.html        # HUD em DOM + áudio inline (window.rebcm.sfx)
    ├── style.css         # Pixel-perfect com Press Start 2P + crosshair premium
    ├── manifest.json     # PWA
    ├── _headers          # Cloudflare cache headers
    ├── favicon.svg/.png
    └── src/              # 19 módulos ES (~28K LOC total)
        ├── main.js           # Entry: init, loop, handlers de ação (~3300 LOC)
        ├── state.js          # Estado global compartilhado
        ├── constants.js      # 1000 BLOCO + 210 ITEM + RECEITAS + dimensões (~3500 LOC)
        ├── utils.js          # Hashes, AO, A* pathfinding, Perlin noise
        ├── audio.js          # Wrapper sfx + Spatial Audio 3D HRTF + reverb
        ├── world.js          # Chunks, World, lighting, geração, dimensões (~1500 LOC)
        ├── render.js         # Renderer Three.js, atlas, mesh builder, sky shader, bloom (~9000 LOC)
        ├── player.js         # Player, física AABB, swim, climb, mounts, elytra glide
        ├── inventory.js      # Inventario, Drops, Crafting
        ├── mobs.js           # 65 mobs, IA ranged/melee, A*, line-of-sight, panic (~3000 LOC)
        ├── particles.js      # Partículas, ItemDrop, XPOrb, Arrow, leaf/snow/pollen/spark
        ├── ui.js             # HUD, paineis, F3, pause, criativo, status effects sidebar
        ├── save.js           # Multi-save v5 (rebcm3d_world_<name>)
        ├── input.js          # Keyboard + mouse + touch + settings sliders
        ├── achievements.js   # 64 conquistas com toast verde
        ├── weather.js        # Chuva, neve acumula, trovão, sky tinting, lightning strike
        ├── multiplayer.js    # BroadcastChannel + WebSocket ghosts
        ├── quality.js        # 4-tier adaptive quality + FPS monitor
        └── chunkgen-worker.js # Worker thread pra chunk gen async
```

### Decisões de design chave

- **Sem build step.** `index.html` carrega `src/main.js` direto via importmap CDN (Three.js).
- **ES modules nativos.** Sem Webpack/Vite/Rollup/TypeScript/JSX.
- **Sem dependências runtime extras.** Só Three.js. Sem React/Vue/jQuery/Lodash.
- **Sem transparência em blocos.** Todos opacos — paridade Minecraft fast graphics.
- **Iluminação 15 níveis** (skylight + blocklight) com flood-fill BFS por chunk.
- **AO por vértice** — Ambient Occlusion calculado no mesh builder.
- **Custom shape system**: BLOCO_INFO[t].shape ('slab' | 'fence' | 'ladder' | 'door' | 'door_open' | 'flower' | 'stairs' | 'wall' | 'button' | 'plate' | 'lever' | 'bars' | 'torch' | 'plate' | 'pot') → mesh + colisão specializada.
- **Estado compartilhado** em `state.js` (objeto mutável) — evita ciclos de import.
- **Multi-dimensão**: `world._chunksOverworld` + `_chunksNether` + `_chunksEnd` em paralelo, swap em `trocarDimensao()`.
- **Sky shader GLSL custom** (vertex + fragment) — gradient dinâmico horizon→zenith.
- **Post-processing pipeline** via Three.js addons (EffectComposer + UnrealBloomPass + ShaderPass + OutputPass).

Detalhes em [`ARCHITECTURE.md`](ARCHITECTURE.md) e [`docs/MODULES.md`](docs/MODULES.md).

---

## 🔧 Rodar local

```bash
git clone https://github.com/rebcm/game
cd game/web3d
python3 -m http.server 8000
# Acesse http://localhost:8000
```

**Requisitos:** apenas um browser moderno. **Sem `npm install`** — o `package.json` é intencionalmente ausente.

ES modules exigem HTTP (não funciona via `file://`).

Pra validar antes de commitar:

```bash
# Sintaxe
for f in web3d/src/*.js; do node --check "$f"; done

# 124 smoke tests
TMPDIR=$(mktemp -d) && cp -R web3d/* "$TMPDIR/" && \
  cp scripts/test-web3d-precheck.js "$TMPDIR/_p.js" && \
  ( cd "$TMPDIR" && node ./_p.js . ) && rm -rf "$TMPDIR"
```

---

## ☁️ Deploy

### Game (Cloudflare Pages)

```bash
# .env precisa ter CLOUDFLARE_API_TOKEN + CLOUDFLARE_ACCOUNT_ID
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

O script: copia `web3d/` → cache-bust `__BUILD_VERSION__` → valida sintaxe → roda 124 smoke tests → publica via `wrangler pages deploy`. Aborta se algum teste falhar.

A cada `git push origin main`, GitHub Actions executa o mesmo script automaticamente.

### Worker de multiplayer (Cloudflare Workers)

```bash
cd worker
set -a; source ../.env; set +a
npx -y wrangler@latest deploy
```

Deploya `worker/src/index.js` em `https://construcao-criativa-mp.rebcm-mp.workers.dev` (subdomain configurada). Free tier inclui Durable Objects SQLite-backed (compat date 2024-09-23+).

---

## 📜 Histórico de sprints

### Sprints regulares (1 a 33)
- **Sprints 1-11** — QoL, Building, Endgame, Population, World Mechanics, IA, Geração, Multiplayer, Nether
- **Sprints 12-33** — 1000 blocos paritários com Minecraft

### Sprints MEGA paridade Minecraft 1.21 (1 a 20)

| # | MEGA | Conteúdo |
|---|------|----------|
| 1 | Items + Effects | 100+ items, 17 efeitos, 60 encantamentos |
| 2 | Mobs | 28 mobs novos (Wither, Warden, Guardian, Horse, Piglin) |
| 3 | Estruturas | 8 (Stronghold, Nether Fortress, End City, Ancient City, Trial Chamber) |
| 4 | Sistemas | Sleep mechanics, Beacon 4 tiers, Conduit, Respawn Anchor |
| 5 | Biomas+Trading | 6 biomas + 15 profissões villager |
| 6 | Polish | Status Effects HUD, Spawn Eggs, Totem of Undying |
| 7-8 | Models 3D + Wither ritual | 28 mob models + spawn rules + summon ritual |
| 9 | Redstone + End Portal | Lever→pistons/TNT, End Portal 12 eyes |
| 10 | AI Ranged + Bosses | Wither 3-shot, Warden Sonic Boom, Evoker Vex |
| 11 | Crops 13 tipos | Hidratação, bonemeal, growth stages 0-7 |
| 12 | Tree Growth 8 tipos | Oak/Birch/Spruce/Jungle/Acacia/Dark/Cherry/Mangrove |
| 13 | Hopper/Observer | Item transfer, Daylight Sensor, Observer pulse |
| 14 | Crafting Tables | Smithing/Stonecutter/Loom/Cartography/Brewing/Composter |
| 15 | Lightning + Snow | Strikes 8 dano, snow accumulation |
| 16 | Sign+ItemFrame+Painting | Editing, item display, painting placement |
| 17 | Mounts/Tame/Elytra | Wolf/Cat/Parrot tame, Horse mount, Elytra glide |
| 18 | Crossbow+Trident+Mace | Multishot, Riptide, Smash attack 1.21 |
| 19 | Raids+Insomnia | Bad Omen, Phantom 3 dias |
| 20 | Sculk+Achievements | 64 achievements, Sculk Spread |

### Sprints VISUAL premium (1 a 9)

| # | VISUAL | Conteúdo |
|---|--------|----------|
| 1 | Sky Dome Shader | Gradient GLSL horizon→zenith dinâmico |
| 2 | Helpers Premium | pintarPremium/PedraPremium/GemPremium/MadeiraPremium/FolhaPremium |
| 3 | Bloom Post-Processing | UnrealBloomPass + Vignette + Color Grading |
| 4 | Tone Mapping | ACES Filmic + exposure 1.15, saturation 1.10 |
| 5 | Nuvens Parallax | 2 layers com gradient radial soft |
| 6 | Particles Ambientes | Pétalas caindo, faíscas, snowflakes, pollen |
| 7 | Concretos Premium | 6 cores com gradient + bevel |
| 8 | Água/Lava/Glowstone | Reflexos solares, bolhas fogo, glow radial bloom |
| 9 | Crosshair + Selection | Dot central + glow, cube outline 12 edges |

### Sprint AUDIO-3D

- **Spatial Audio** com HRTF + distance inverse-square
- **Reverb procedural** ConvolverNode 1.8s decay
- **6 ambient loops** por bioma com LFO modulação
- **Listener tracking** posição + forward + up vector

---

## 📚 Documentação

| Arquivo | Conteúdo |
|---------|----------|
| [`README.md`](README.md) | Visão geral pública (você está aqui) |
| [`CLAUDE.md`](CLAUDE.md) | Instruções pra Claude Code em modo auto-continue |
| [`AGENTS.md`](AGENTS.md) | Regras detalhadas pra qualquer agente de IA |
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | Arquitetura técnica detalhada (fluxo, decisões, pipeline) |
| [`docs/MODULES.md`](docs/MODULES.md) | Referência por módulo (19 módulos JS) |
| [`docs/walkthrough.md`](docs/walkthrough.md) | Guia passo-a-passo do jogo |
| [`docs/SETUP.md`](docs/SETUP.md) | Setup de desenvolvimento + troubleshooting |

---

## 🏆 Créditos

**Autora:** **Rebeca Alves Moreira**

**Tecnologias:**
- [Three.js](https://threejs.org/) (BSD-3) — engine 3D WebGL via importmap CDN
- [Three.js Postprocessing addons](https://threejs.org/) — UnrealBloomPass, ShaderPass, EffectComposer
- [Cloudflare Pages](https://pages.cloudflare.com) — hospedagem do game (free tier)
- [Cloudflare Workers](https://workers.cloudflare.com) — multiplayer signaling (free tier com Durable Objects SQLite)
- Web Audio API — SFX procedurais + Spatial Audio 3D HRTF + reverb procedural
- Press Start 2P (Google Fonts) — tipografia pixel-perfect

**Inspirado em** Minecraft (Mojang Studios). Projeto educacional independente, sem afiliação.

**Licença:** [MIT](LICENSE) — livre pra usar, modificar, distribuir, comercializar. Mantenha o copyright original.

---

<div align="center">

### 🎮 [JOGAR AGORA →](https://construcao-criativa.pages.dev)

*"1000 blocos. 65 mobs. Áudio 3D. Bloom premium. Sem instalar nada."* 🧱✨

</div>
