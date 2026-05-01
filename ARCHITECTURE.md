# Construção Criativa da Rebeca — Arquitetura

**Autora:** Rebeca Alves Moreira  
**Plataformas:** Android · iOS · Web (Cloudflare Workers)  
**Versão:** 0.1.0

## Conceito

Jogo de blocos voxel modo criativo puro. O jogador recebe acesso a todos os blocos e molda livremente o mundo ao redor. Sem sobrevivência, sem mobs, sem campanhas, sem biomas alternativos. Apenas construção livre no bioma principal.

## Stack

| Camada | Tecnologia |
|--------|-----------|
| UI / Jogo | Flutter 3.x (Dart) |
| Renderização | `CustomPainter` isométrico 2.5D |
| Estado | `provider` (`ChangeNotifier`) |
| Mundo | Chunks de voxel 16×16×64 |
| Persistência local | `shared_preferences` (slot do inventário, última posição) |
| Backend | Cloudflare Workers (persistência de mundos) |
| CI/CD | GitHub Actions (release diário 20:00 BRT) |
| Web | Cloudflare Pages via `wrangler` |

## Estrutura de Diretórios

```
lib/
├── main.dart                  # Ponto de entrada, orientação paisagem, imersivo
├── app/
│   └── app.dart               # MaterialApp + MultiProvider root
├── blocos/
│   └── tipo_bloco.dart        # Enum TipoBloco + extensões (cor, nome, físicas)
├── mundo/
│   ├── posicao3d.dart         # Coordenada inteira x/y/z
│   ├── chunk.dart             # Chunk 16×16×64: armazenamento e serialização
│   ├── gerador.dart           # Gerador procedural: heightmap sin/cos + árvores
│   └── mundo.dart             # Cache de chunks, coordenadas, altura da superfície
├── personagem/
│   └── rebeca.dart            # Classe Rebeca: posição, inventário 9 slots, render Canvas
├── jogo/
│   ├── estado_jogo.dart       # EstadoJogo ChangeNotifier: tela, stats, mundo, rebeca
│   └── renderizador_isometrico.dart  # CustomPainter: projeção 2.5D, 3 faces por bloco
├── ui/
│   ├── tela_inicio.dart       # Tela inicial animada, campo nome do mundo, play
│   ├── tela_jogo.dart         # Loop principal: teclado, gestos, toque → colocar/remover
│   └── hud.dart               # HUD: coordenadas, hotbar, inventário completo
├── backend/
│   └── api_cliente.dart       # HTTP singleton para Cloudflare Workers
└── config/
    └── constantes.dart        # Constantes do jogo (tamanho chunk, velocidade, URL API)
```

## Renderização Isométrica

O jogo usa projeção isométrica 2.5D clássica:

```
Ponto 3D (x, y, z) → Ponto 2D:
  screenX = (x - z) * (TAMANHO_BLOCO / 2)
  screenY = (x + z) * (TAMANHO_BLOCO / 4) - y * (TAMANHO_BLOCO / 2)
```

Cada bloco renderiza 3 faces via `Path`:
- **Topo** (face superior): mais clara
- **Esquerda** (face norte/oeste): média
- **Direita** (face sul/leste): mais escura

Ordem de renderização: Y crescente (chão para cima), Z crescente (fundo para frente).

## Sistema de Chunks

- Tamanho: 16 (X) × 16 (Z) × 64 (Y)
- Armazenamento: `Uint8List` de 16.384 bytes (1 byte por bloco = índice do `TipoBloco`)
- Cache: `Map<String, Chunk>` em memória por `"$cx,$cz"`
- Geração sob demanda (`Gerador.gerarChunk`)
- Serialização: `paraJson()` / `deJson()` para sync com backend

## Personagem Rebeca

- Posição contínua `(x, y, z)` em `double`
- Inventário: lista de 9 `TipoBloco`, slot selecionado
- Direção de olhar: `DirecaoOlhar.norte/sul/leste/oeste`
- `blocoDaFrente`: calcula o bloco à frente para colocar/remover
- Renderização própria via `Canvas` (sprite procedural)

## Blocos Disponíveis (Modo Criativo)

| Tipo | Cor | Propriedades |
|------|-----|-------------|
| Grama | Verde | Sólido |
| Terra | Marrom | Sólido |
| Pedra | Cinza | Sólido |
| Areia | Amarelo | Sólido |
| Água | Azul 50% | Transparente |
| Madeira | Marrom claro | Sólido |
| Folhas | Verde escuro | Transparente |
| Vidro | Azul 25% | Transparente |
| Tijolos | Vermelho | Sólido |
| Neve | Branco | Sólido |
| Tronco | Marrom escuro | Sólido |
| Ouro | Dourado | Sólido |
| Diamante | Ciano | Sólido |
| Luz | Amarelo claro | Sólido, emite luz |

## Controles

### Teclado (Desktop / Web)
| Tecla | Ação |
|-------|------|
| W / ↑ | Mover norte |
| S / ↓ | Mover sul |
| A / ← | Mover oeste |
| D / → | Mover leste |
| Espaço | Subir (y+1) |
| Shift | Descer (y-1) |
| E | Abrir/fechar inventário |
| 1-9 | Selecionar slot |

### Touch (Android / iOS)
| Gesto | Ação |
|-------|------|
| Arrastar 1 dedo | Mover personagem |
| Pinça 2 dedos | Zoom |
| Toque simples | Colocar / remover bloco à frente |

## Backend (Cloudflare Workers)

URL: `https://construcao-criativa.workers.dev`

| Endpoint | Método | Descrição |
|---------|--------|-----------|
| `/auth/login` | POST | Autenticação, retorna JWT |
| `/mundos` | GET | Listar mundos do usuário |
| `/mundos/chunks` | POST | Salvar chunk |
| `/mundos/chunks/:cx/:cz` | GET | Carregar chunk |

O backend é opcional — o jogo funciona offline com geração procedural local.

## CI/CD — GitHub Actions

Executa **diariamente às 20:00 BRT (23:00 UTC)** e em pushes para `main`.

| Job | Runner | Artefato |
|-----|--------|----------|
| `build-android` | `ubuntu-latest` | APK + AAB assinados |
| `build-ios` | `macos-latest` | IPA (requer certificados Apple) |
| `deploy-web` | `ubuntu-latest` | Flutter web → Cloudflare Pages |

### Segredos necessários no GitHub

| Secret | Descrição |
|--------|-----------|
| `ANDROID_KEYSTORE_B64` | Keystore Base64 para assinar APK |
| `ANDROID_KEY_ALIAS` | Alias da chave no keystore |
| `ANDROID_STORE_PASSWORD` | Senha do keystore |
| `ANDROID_KEY_PASSWORD` | Senha da chave |
| `CLOUDFLARE_API_TOKEN` | Token Cloudflare para deploy Pages |
| `CLOUDFLARE_ACCOUNT_ID` | ID da conta Cloudflare |

## Regras de Desenvolvimento para Agentes

Ver [AGENTS.md](AGENTS.md) para instruções completas de como evoluir o projeto.

## Roadmap

### v0.1 (atual) — Fundação
- [x] Renderização isométrica funcional
- [x] Mundo procedural (chunks 16×16×64)
- [x] Personagem Rebeca com inventário criativo
- [x] Colocar e remover blocos
- [x] Controles teclado + touch
- [x] HUD (coordenadas, hotbar, inventário)

### v0.2 — Polimento
- [ ] Texturas de pixel art nos blocos (substituir cores planas)
- [ ] Som ao colocar/remover blocos
- [ ] Persistência local do mundo (SharedPreferences)
- [ ] Seleção de bloco por toque na hotbar com animação

### v0.3 — Multiplataforma
- [ ] Build Android assinado (Google Play)
- [ ] Deploy web estável (Cloudflare Pages)
- [ ] Tela de splash com logo da Rebeca

### v0.4 — Backend
- [ ] Sincronização de mundos via Cloudflare Workers
- [ ] Múltiplos slots de mundo salvo
- [ ] Exportar screenshot do mundo
