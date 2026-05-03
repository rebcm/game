# 🧱 Construção Criativa da Rebeca

> Jogo voxel isométrico no estilo Minecraft — modo criativo puro, feito com Flutter + Flame.

**🎮 [JOGAR AGORA](https://construcao-criativa.pages.dev)**

---

## Sobre o Jogo

Construção Criativa da Rebeca é um jogo de blocos 3D com visão isométrica, inspirado no modo criativo do Minecraft. O objetivo é simples: explore o mundo gerado proceduralmente, construa livremente, quebre blocos e deixe a criatividade fluir.

Não há inimigos, não há fome, não há morte. Apenas construção.

**Autora:** Rebeca Alves Moreira

---

## 🎮 Jogar Online

Acesse diretamente no navegador, sem instalação:

**[https://construcao-criativa.pages.dev](https://construcao-criativa.pages.dev)**

Funciona em celular, tablet e desktop. Recomendado no modo paisagem (landscape).

---

## Funcionalidades

### 🌍 Mundo
- Mapa **32 × 32 × 20 blocos** gerado proceduralmente com variação de altura natural
- Terreno suave com ondas senoidais em múltiplas frequências
- Superfícies diferenciadas por altitude: **areia** (baixo), **grama** (médio), **neve** (alto)
- **18 árvores** com troncos e copas esféricas distribuídas pelo mapa
- **Minérios** (ouro e diamante) escondidos na pedra underground
- Camadas geológicas realistas: grama → terra → pedra

### 🧱 Blocos (13 tipos)

| Bloco | Ícone | Cor | Descrição |
|-------|-------|-----|-----------|
| Grama | 🌿 | Verde | Superfície dos campos |
| Terra | 🟫 | Marrom | Solo abaixo da grama |
| Pedra | 🪨 | Cinza | Rocha base do terreno |
| Areia | 🏖 | Amarelo | Praias e vales |
| Madeira | 🪵 | Bege | Troncos das árvores |
| Folha | 🌳 | Verde-escuro | Copa das árvores |
| Tijolo | 🧱 | Vermelho-tijolo | Construção clássica |
| Vidro | 🔷 | Azul translúcido | Janelas e decoração |
| Ouro | 🥇 | Dourado | Minério raro |
| Diamante | 💎 | Ciano | Minério mais raro |
| Luz | 💡 | Amarelo-claro | Bloco de iluminação |
| Neve | ❄️ | Branco | Topo das montanhas |

### 🖼️ Renderização Isométrica
- **4 ângulos de câmera** isométrica: **NE · SE · SW · NW** — gire para ver o mundo de todos os lados
- **Algoritmo do pintor** (painter's algorithm) para ordem de renderização correta em profundidade
- **Culling de faces ocultas**: apenas as faces visíveis de cada bloco são desenhadas
- **Culling de frustum**: blocos fora da tela são ignorados (performance otimizada)
- **3 faces com sombreamento**: topo (claro), esquerda (escuro), direita (médio)
- **Céu gradiente** do azul profundo ao azul claro, com nuvens decorativas
- **Sombra suave** sob a personagem com efeito blur

### 👧 Personagem — Rebeca
- Avatar em forma de losango rosa com olhos e detalhe de roupa
- **Modo voo criativo** permanente — sem gravidade, sobe e desce livremente
- Movimento suave em todas as direções
- **Colisão com blocos** detectada por raio de 1 bloco
- **Raycasting de mira**: detecta o bloco alvo na direção do movimento (alcance 6 blocos)
- A direção do personagem é atualizada automaticamente pelo joystick

### ⚒️ Mecânicas de Jogo
- **Colocar bloco**: aperte 🧱 para colocar o bloco selecionado sobre o bloco alvo
- **Quebrar — instantâneo**: toque rápido em ⛏ remove o bloco imediatamente
- **Quebrar — progressivo**: segure ⛏ (long press) para quebrar com animação de 4 estágios
- **Bloco alvo destacado**: outline branco indica qual bloco será afetado
- **Animação de rachaduras**: 4 estágios de crack durante a quebra progressiva

### 🖥️ Interface (HUD)
- **Mira central**: crosshair com sombra sempre visível no centro da tela
- **Mão do jogador**: cubo isométrico mini no canto inferior direito mostrando o bloco selecionado
- **Hotbar com 8 slots**: base da tela com ícone, cor e nome do bloco ativo
- **Coordenadas em tempo real**: posição X, Y, Z no canto superior esquerdo
- **Indicador de câmera**: ângulo atual (NE/SE/SW/NW) com botão de rotação 🔄

---

## 🕹️ Controles

### Celular / Tablet (Touch)
| Controle | Ação |
|----------|------|
| 🕹️ Joystick esquerdo | Mover Rebeca em todas as direções |
| ▲ (topo direito) | Subir (voar) |
| ▼ (topo direito) | Descer (voar) |
| 🧱 Colocar | Colocar bloco selecionado |
| ⛏ Quebrar (toque rápido) | Quebrar bloco instantaneamente |
| ⛏ Quebrar (segurar) | Quebrar com animação progressiva |
| 🔄 (canto inferior esq.) | Rotacionar câmera → NE → SE → SW → NW |
| Hotbar (base da tela) | Selecionar tipo de bloco |

### Desktop / Web (Teclado)
| Tecla | Ação |
|-------|------|
| `W` / `↑` | Mover para frente (NE) |
| `S` / `↓` | Mover para trás (SW) |
| `A` / `←` | Mover para esquerda (NW) |
| `D` / `→` | Mover para direita (SE) |
| `Espaço` | Subir (voar) |
| `Shift Esq.` | Descer (voar) |
| `R` | Rotacionar câmera isométrica |

---

## 🛠️ Tecnologia

| Componente | Tecnologia |
|-----------|-----------|
| Framework | [Flutter](https://flutter.dev) 3.24+ |
| Game Engine | [Flame](https://flame-engine.org) ^1.18.0 |
| Linguagem | Dart 3.0+ |
| Renderização | Isométrica custom com painter's algorithm |
| Geração de terreno | Sine-wave layered noise |
| Build web | `flutter build web --release --base-href /` |
| Deploy | [Cloudflare Pages](https://pages.cloudflare.com) |
| CI/CD | GitHub Actions |

### Arquitetura do Código
```
app/lib/
├── main.dart                          # Entrada: landscape + immersive mode
├── constantes.dart                    # Dimensões isométricas, velocidades, alcances
├── blocos/
│   └── tipo_bloco.dart               # 13 blocos: enum + cores (3 faces) + propriedades
├── mundo/
│   └── mundo.dart                    # Grid 3D + geração procedural + árvores + minérios
├── personagem/
│   └── rebeca.dart                   # Movimento, direção, raycasting, progresso de quebra
├── renderizador/
│   └── renderizador_isometrico.dart  # Painter's algorithm, câmeras, highlight, mão, crosshair
├── jogo/
│   └── construcao_criativa.dart      # FlameGame: loop, teclado, TapCallbacks, ações
└── ui/
    └── controles_overlay.dart        # Joystick, botões, hotbar animada, HUD de coords
```

---

## 🚀 Build e Desenvolvimento Local

### Pré-requisitos
- Flutter SDK 3.24 ou superior
- Dart 3.0+

### Executar
```bash
git clone https://github.com/rebcm/game
cd game/app

flutter pub get
dart analyze --no-fatal-warnings     # Zero erros obrigatório
flutter run                          # Rodar em dispositivo/emulador
```

### Build Web
```bash
flutter build web --release --base-href /
# Output em: app/build/web/
```

---

## 🌐 Deploy Automático

A cada push para `main`, o GitHub Actions:
1. Instala Flutter 3.24 stable
2. Executa `flutter pub get`
3. Valida com `dart analyze --no-fatal-warnings`
4. Faz `flutter build web --release`
5. Deploya automaticamente no **Cloudflare Pages**

**URL de produção:** [https://construcao-criativa.pages.dev](https://construcao-criativa.pages.dev)

---

## 📋 Regras do Projeto

Este projeto segue regras invioláveis definidas em `AGENTS.md`:

1. **Modo criativo puro** — sem sobrevivência, saúde, fome, morte ou mobs
2. **Um único bioma** — sem portais, fases ou dimensões adicionais
3. **Sem NPCs ou monstros** — a única personagem é a Rebeca
4. **Código 100% funcional** — nenhum stub, TODO ou implementação parcial aceita
5. **`dart analyze` sem erros** — obrigatório antes de qualquer commit
6. **Autoria preservada**: `Constantes.autora = 'Rebeca Alves Moreira'`

---

## 🏆 Créditos

**Autora e personagem principal:** Rebeca Alves Moreira  
**Motor de jogo:** [Flame](https://flame-engine.org) + [Flutter](https://flutter.dev)  
**Hospedagem:** [Cloudflare Pages](https://pages.cloudflare.com)  

---

*"Construa mundos. Não há limites."* 🧱✨
