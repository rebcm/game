# 🧱 Construção Criativa da Rebeca

> Jogo voxel inspirado no Minecraft, em primeira/terceira pessoa, rodando 100% no navegador. Mundo infinito por chunks, modos Criativo e Sobrevivência, mobs, crafting, fornalha, baú, ciclo dia/noite e muito mais.

**🎮 [JOGAR AGORA](https://construcao-criativa.pages.dev)**

**Autora:** Rebeca Alves Moreira

---

## 🌟 Sobre o Jogo

Construção Criativa é um jogo de blocos 3D inspirado no Minecraft, escrito do zero em **JavaScript com Three.js + WebGL**. Roda inteiro no navegador — sem instalação, sem Flash, sem cliente nativo. Funciona em desktop, celular e tablet.

Você pode escolher entre dois modos:

- **🦅 Modo Criativo** — voo livre, blocos infinitos, sem dano, inventário com abas e busca para colocar qualquer bloco/item da Rebeca.
- **⚔ Modo Sobrevivência** — gravidade, fome, oxigênio submerso, dano de queda, lava, cacto, mobs hostis. Você junta recursos, fabrica ferramentas e armaduras, cozinha comida e sobrevive à noite.

Alterne entre eles a qualquer momento com a tecla `G`.

---

## 🚀 Como Jogar

Acesse o navegador e clique em **JOGAR EM TELA CHEIA**:

**[https://construcao-criativa.pages.dev](https://construcao-criativa.pages.dev)**

Funciona em qualquer dispositivo moderno (Chrome, Firefox, Safari, Edge). Em celular e tablet, recomenda-se modo paisagem.

---

## ✨ Funcionalidades

### 🌍 Mundo
- **Mundo voxel infinito**, gerado por chunks de 16×16×64 sob demanda enquanto você caminha.
- Terreno com **areia, grama, neve e pedra**, distribuído por altitude e ruído (paridade visual com Minecraft).
- **Bedrock** indestrutível nas três camadas inferiores.
- **Cavernas subterrâneas** geradas por ruído 3D.
- **Minérios** distribuídos por profundidade: carvão (raso) → ferro → ouro → diamante (fundo).
- **Estruturas espalhadas**: árvores, cabanas com workbench, cactos no deserto, lagos de lava.
- **Ciclo dia/noite real**, durando 4 minutos por dia, com sol e lua animados em arco e nuvens em movimento.

### 🧱 26 Tipos de Bloco

| 🧱 Construção | 🌿 Natureza | 💎 Minérios | 💧 Líquidos | 🪟 Decoração | ⚒ Funcionais |
|:---:|:---:|:---:|:---:|:---:|:---:|
| Tijolo, Pedra, Madeira | Grama, Terra, Areia, Folha, Cacto, Neve | Carvão, Ferro, Ouro, Diamante, Obsidiana | Água, Lava | Vidro, Lã, Tocha, Cama, Luz | Workbench, Baú, Fornalha, Bedrock |

Cada bloco tem **textura procedural pixelada** estilo Minecraft, gerada em tempo real num atlas.

### 👧 Personagem — Rebeca
- Movimento WASD com **sprint** (Shift), **agachar** (Ctrl) e **pulo** (Espaço).
- **Voo livre** no Criativo (Espaço sobe, Shift desce).
- **Câmera 1ª/3ª pessoa** com `F5`.
- **Animação de mão** com swing realista ao quebrar/colocar.
- **FOV pulse** ao sprintar (paridade Minecraft).

### ⚔ Mobs (11 tipos)
- **Pacíficos**: 🐄 vaca, 🐔 galinha, 🐖 porco, 🐑 ovelha, 🐺 lobo (ataca hostis automaticamente).
- **Hostis** (spawnam onde a luz ≤ 7): 🧟 zumbi, 💀 esqueleto, 🕷 aranha, 💥 creeper, 🟢 slime (pula em arcos), 🟣 enderman (teleporta).
- Modelos 3D com cabeça, corpo, braços, pernas animadas estilo Minecraft.
- **Sons específicos** por espécie (rosnado, balido, mugido, sibilo do creeper, click do esqueleto).
- **Drops realistas**: vaca solta carne crua + couro, galinha solta ovo, esqueleto solta paus, etc.
- **IA com call ocasional** quando você está perto, e vocaliza ao apanhar.

### 🎒 Inventário e Crafting
- **Hotbar de 9 slots** (paridade Minecraft).
- **Inventário** 27 slots + 4 slots de armadura (capacete/peitoral/perneiras/botas).
- **Crafting** com 25+ receitas: pranchas, paus, picaretas (4 tiers), espadas (3 tiers), armaduras (couro/ferro/diamante), workbench, baú, fornalha, cama, tochas.
- **Workbench** habilita receitas avançadas quando próximo.
- **Fornalha** cozinha carne crua → cozida (ou minérios → lingotes) com combustível.
- **Baú** armazena 27 slots.
- **Cama** pula a noite quando você dorme (restaura HP).
- **Inventário Criativo** com abas (🧱 construção, 🌿 natureza, 💎 minérios, 💧 líquidos, 🪟 decoração, ⛏ ferramentas, ⚔ combate, 🍖 comida) e busca por nome.

### ⚒ Ferramentas e Combate
- **Picaretas em 4 tiers** (madeira → pedra → ferro → diamante). Tier mais alto = mais rápido + acessa minérios mais raros.
- **Espadas em 3 tiers** (madeira → pedra → ferro). Dano = 2 + tier × 2.
- **Armadura em 3 tiers** com até 21 pontos de defesa total (paridade Minecraft).
- **XP** ao minerar minérios e derrotar mobs, com curva de níveis.

### 🩸 Sistema de Sobrevivência
- **20 HP** (10 corações), com regeneração quando bem alimentado.
- **20 pontos de fome** com sistema de **saturação** (paridade Minecraft).
- **20 pontos de oxigênio** (10 bolhas) submerso.
- **Dano por queda** (>4 blocos), lava (3/0.5s), cacto (1/0.5s), afogamento (2/1s).
- **Sneak (Ctrl)** impede cair de borda.
- **Swimming**: água reduz velocidade a 55%, gravidade a 12%; bracejar pra subir.
- **Item drops voando**: blocos quebrados e drops de mobs viram entidades visíveis flutuantes que você coleta a 1.5m.
- **XP orbs verdes brilhantes** ao matar mobs e minerar — voam até você quando chega a 5m.
- **Critical hit** (golpe caindo): 1.5× dano com som especial, paridade Minecraft.
- **Knockback** no mob ao ser atingido.
- **Camera shake** proporcional ao dano recebido.

### 🖥️ HUD e UI
- **Crosshair** estilo Minecraft (cruz pixelada com inverter).
- **Barras visuais**: ❤ HP (corações), 🍗 fome, 💎 XP com nível, 🫧 ar (submerso).
- **Vinheta** nas bordas + **flash vermelho** ao receber dano + **pulse low-HP** quando crítico.
- **Tela de morte** com causa formatada + botão Respawn.
- **Pause menu** (ESC) com Voltar / Salvar / Modo / Sair.
- **F3 debug overlay** com XYZ, chunk, facing, light level, biome, FPS, MB de heap, dia/hora, contagem de entidades.
- **Tooltips** ao passar o mouse em itens (nome, tier, defesa, nutrição).
- **Highlight do bloco mirado** com outline preto+branco e cracks progressivos durante a quebra.

### 🎵 Áudio
- **SFX procedurais** via Web Audio API, gerados em runtime sem arquivos:
  - **Passos por material** (grama, pedra, madeira, areia, água, folha, neve, metal, vidro).
  - **Sons de mob** específicos: rosnado de zumbi, click de esqueleto, sibilo de creeper, mugido de vaca, balido de ovelha, oink de porco, cluck de galinha, latido de lobo, plop de slime, whoosh de teleport do enderman.
  - **Sons ambiente** contextuais: drips de caverna (quando skylight=0 + subterrâneo), ventos em altitude, rumble de caverna profunda.
  - **Sons de UI**: abrir/fechar baú, deitar na cama, equipar armadura, comer crunchy, page flip do inventário.
  - **Combate**: hit do mob, hurt do player (mais grave), critical hit (agudo), bow draw/release, arrow whoosh.
  - **Outros**: quebrar, colocar, splash, bolha, level-up, pickup, XP orb, explosão.
- **Música ambiente** em loop com progressão harmônica de 4 acordes + melodia esparsa em escala diatônica, gerada proceduralmente em tempo real.

### 💾 Save / Load
- **Autosave a cada 30 segundos** no `localStorage`.
- Salva: posição, HP, fome, XP, nível, modo, hora do dia, inventário, armadura, blocos modificados, baús e fornalhas.
- Botão **💾 Salvar** ou opção pelo menu de pause.

---

## 🕹️ Controles

### 🖱 Desktop (Teclado + Mouse)

| Tecla | Ação |
|-------|------|
| `Mouse` | Olhar (pointer lock) |
| `W A S D` | Mover |
| `Espaço` | Pular / subir (Criativo) |
| `Shift` | Sprintar (Sobrevivência) / descer (Criativo) |
| `Ctrl` | Agachar (sneak) |
| `Click esq.` | Quebrar bloco (segurar para quebra progressiva) |
| `Click dir.` | Colocar bloco / interagir |
| `Scroll` ou `1`–`9` | Trocar slot da hotbar |
| `E` | Inventário (Criativo abre painel com abas) |
| `C` | Painel de Crafting |
| `F` | Atacar mob mais próximo |
| `Q` | Comer item da hotbar |
| `G` | Alternar Criativo / Sobrevivência |
| `T` | Alternar transparência de blocos |
| `F5` | Trocar 1ª / 3ª pessoa |
| `F3` | Tela de debug (XYZ, chunk, luz, bioma, FPS) |
| `F1` | Esconder / mostrar HUD |
| `Esc` | Pausar |

### 📱 Celular / Tablet (Touch)

| Controle | Ação |
|----------|------|
| 🕹️ Joystick (esq.) | Mover (knob na borda = sprint) |
| ☝️ Arrastar (dir.) | Olhar |
| ↑ | Pular |
| ↓ | Descer (só no Criativo) |
| ⛏ | Quebrar bloco (segurar) |
| 🧱 | Colocar bloco |
| ⚔ | Atacar mob |
| 📦 ⚒ 🦅 💾 🪟 | Botões de inventário, craft, modo, salvar, transparência |

---

## 🛠️ Tecnologia

| Componente | Stack |
|------------|-------|
| Renderização | [Three.js 0.165](https://threejs.org/) + WebGL |
| Linguagem | JavaScript ES2022 (módulos nativos) |
| Áudio | Web Audio API (SFX procedurais) |
| Persistência | `localStorage` |
| Build | **Sem build step** — `index.html` carrega `game.js` diretamente |
| Cache busting | `__BUILD_VERSION__` substituído no deploy pelo timestamp |
| Hospedagem | [Cloudflare Pages](https://pages.cloudflare.com) |
| CI/CD | GitHub Actions + Wrangler |

### 📂 Estrutura do Projeto

```
game/
├── web3d/                    # 🎮 VERSÃO ATUAL (Three.js)
│   ├── index.html            # HTML + HUD + áudio inline
│   ├── style.css             # Estilo pixel-perfect
│   ├── game.js               # Engine 3D completo (~4200 linhas)
│   └── manifest.json
├── lib/                      # 🧊 Versão antiga Flutter 2D isométrico
├── app/                      # Wrapper Flutter (compila lib/)
├── docs/                     # Documentação técnica
├── scripts/
│   ├── deploy-web3d.sh       # Script de deploy Cloudflare Pages
│   └── test-web3d-precheck.js # Smoke tests pré-deploy
└── README.md                 # Você está aqui
```

A pasta `web3d/` é a versão **atual e ativa**. Ela é totalmente standalone — pode ser servida por qualquer servidor estático.

---

## 🚀 Rodar Localmente

Requer apenas um servidor HTTP estático (qualquer um).

### Opção 1 — Python
```bash
cd web3d
python3 -m http.server 8000
# Acesse http://localhost:8000
```

### Opção 2 — Node
```bash
cd web3d
npx serve .
```

### Opção 3 — Live reload (desenvolvimento)
```bash
cd web3d
npx live-server .
```

> **Importante:** o jogo precisa ser servido por HTTP (não `file://`) por causa de módulos ES e da política de pointer-lock dos browsers.

---

## ☁ Deploy

Deploy é feito via Cloudflare Pages com cache-busting automático.

### Variáveis de ambiente
Crie um `.env` na raiz baseado em `.env.example`:
```bash
CLOUDFLARE_API_TOKEN=seu_token_pages_edit
CLOUDFLARE_ACCOUNT_ID=seu_account_id_32_hex
```

### Deploy manual
```bash
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

O script:
1. Copia `web3d/` para um diretório temporário.
2. Substitui `__BUILD_VERSION__` pelo timestamp UTC atual.
3. Valida sintaxe com `node --check`.
4. Roda smoke tests pré-deploy (`scripts/test-web3d-precheck.js`).
5. Publica via `wrangler pages deploy` no projeto `construcao-criativa`.

### Deploy automático
A cada push para `main`, o GitHub Actions executa o mesmo script automaticamente.

**URL de produção:** [https://construcao-criativa.pages.dev](https://construcao-criativa.pages.dev)

---

## 📋 Filosofia do Projeto

Este projeto foi construído com algumas regras simples:

1. **Diversão primeiro.** O jogo deve ser estável e divertido para a Rebeca jogar.
2. **Web puro.** Sem build step, sem dependências pesadas, sem WASM. Carrega rápido em qualquer celular.
3. **Single-file engine.** Todo o motor 3D em `web3d/game.js` — fácil de auditar, refatorar e clonar.
4. **Código que funciona.** Sem TODO, sem stub, sem implementação parcial. Cada feature roda.
5. **Pixel-perfect Minecraft.** Quando possível, copiamos os números reais do Minecraft (15 níveis de luz, 20 HP, 20 fome, 64 stack, 4 tiers de ferramenta).
6. **Autoria preservada:** Rebeca Alves Moreira aparece em todos os arquivos relevantes e na tela inicial.

---

## 🤝 Como Contribuir

1. Faça fork do repositório.
2. Trabalhe num branch novo: `git checkout -b feature/sua-ideia`.
3. Garanta que `web3d/game.js` passa em `node --check` e que `scripts/test-web3d-precheck.js` está verde.
4. Abra um Pull Request explicando o que mudou e por quê.
5. Mantenha a paridade visual e mecânica com o Minecraft real quando possível.

Veja também o [`AGENTS.md`](AGENTS.md) para regras específicas a agentes de desenvolvimento (Claude Code, Copilot, etc.).

---

## 🏆 Créditos

**Autora e personagem principal:** **Rebeca Alves Moreira**

**Tecnologias:**
- [Three.js](https://threejs.org/) (BSD-3) — engine 3D WebGL
- [Cloudflare Pages](https://pages.cloudflare.com) — hospedagem
- [Wrangler](https://developers.cloudflare.com/workers/wrangler/) — deploy

Inspirado no Minecraft (Mojang/Microsoft). Este é um projeto educacional independente, sem afiliação com a Mojang.

---

## 📜 Licença

Projeto pessoal da Rebeca Alves Moreira. Todos os direitos reservados sobre o código próprio.

Three.js mantém sua licença BSD-3. Texturas, sons e arte são gerados proceduralmente em tempo de execução.

---

*"Construa mundos. Não há limites."* 🧱✨
