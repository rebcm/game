# 🏗️ Construção Criativa da Rebeca

**Autora:** Rebeca Alves Moreira  
**Plataformas:** Android · iOS · Web  
**Web ao vivo:** https://construcao-criativa.pages.dev  
**Repositório:** https://github.com/rebcm/game

---

## O que é este jogo?

**Construção Criativa da Rebeca** é um jogo de blocos voxel com vista isométrica, totalmente no **modo criativo**. O objetivo é simples: construir livremente. Sem sobrevivência, sem fome, sem monstros, sem morte. Apenas você, a paisagem e todos os blocos do mundo à sua disposição.

Inspirado no modo criativo do Minecraft, este jogo foi criado com carinho por Rebeca Alves Moreira para quem ama construir e dar forma ao mundo ao redor.

---

## 🎮 Controles

### Teclado (Web / Desktop)

| Tecla | Ação |
|-------|------|
| `W` ou `↑` | Mover para o norte |
| `S` ou `↓` | Mover para o sul |
| `A` ou `←` | Mover para o oeste |
| `D` ou `→` | Mover para o leste |
| `Espaço` | Subir (voar para cima) |
| `Shift Esq.` | Descer (voar para baixo) |
| `E` | Abrir / fechar inventário |
| `1` a `9` | Selecionar slot do inventário |
| Toque/clique no mundo | Colocar ou remover bloco na frente da Rebeca |

### Touch (Android / iOS)

| Gesto | Ação |
|-------|------|
| Arrastar com 1 dedo | Mover a Rebeca |
| Pinça com 2 dedos | Aumentar / diminuir zoom |
| Toque simples | Colocar ou remover bloco na frente da Rebeca |
| Toque na hotbar | Selecionar bloco |
| Toque no ícone de inventário | Ver todos os blocos disponíveis |

---

## 🧱 Blocos Disponíveis

No modo criativo, você tem acesso a **todos os blocos** desde o início:

| Bloco | Características |
|-------|----------------|
| 🟩 **Grama** | Sólido — superfície do terreno |
| 🟫 **Terra** | Sólido — camada abaixo da grama |
| ⬜ **Pedra** | Sólido — base do terreno |
| 🟡 **Areia** | Sólido — terreno arenoso |
| 🔵 **Água** | Transparente — decorativo |
| 🪵 **Madeira** | Sólido — construção de estruturas |
| 🌿 **Folhas** | Translúcido — copa de árvores |
| 🪟 **Vidro** | Transparente — janelas |
| 🧱 **Tijolos** | Sólido — paredes e construções |
| ❄️ **Neve** | Sólido — decoração invernal |
| 🌲 **Tronco** | Sólido — tronco de árvore |
| 🏅 **Ouro** | Sólido — decoração luxuosa |
| 💎 **Diamante** | Sólido — decoração preciosa |
| 💡 **Luz** | Sólido — iluminação |

---

## 🌍 O Mundo

O mundo é **gerado proceduralmente** — cada partida é única:

- **Chunks de 16 × 16 × 64 blocos** — expande conforme você explora
- **Terreno ondulado** gerado com funções de onda senoidal
- **Camadas** de pedra → terra → grama do fundo para a superfície
- **Árvores** distribuídas aleatoriamente com troncos e copas de folhas
- **Modo voar** — suba e desça livremente com Espaço e Shift

---

## 👧 A Rebeca

A protagonista do jogo é a Rebeca, desenhada como um personagem voxel:

- Vestido rosa 💗
- Cabelo loiro dourado 👱‍♀️
- Olhos azuis 👁️
- Nome exibido acima da cabeça
- Sempre em modo criativo — voa livremente pelo mundo

---

## 🖥️ Interface (HUD)

Durante o jogo:

- **Canto superior esquerdo** — coordenadas X / Y / Z em tempo real
- **Canto superior esquerdo** — contador de blocos colocados
- **Parte inferior** — hotbar com 9 slots de blocos
- **Canto superior direito** — botão de pausa
- **Centro (ao pressionar E)** — inventário completo com todos os blocos

---

## 📱 Como jogar agora

### No navegador (sem instalação)
Acesse diretamente:  
👉 **https://construcao-criativa.pages.dev**

Funciona em Chrome, Firefox, Safari e Edge, em celular, tablet ou computador.

### Android
Baixe o APK em [Releases](https://github.com/rebcm/game/releases) e instale no seu Android.

> Para instalar fora da Play Store: ative "Fontes desconhecidas" nas configurações.

### iOS
Em desenvolvimento — em breve via TestFlight.

---

## 💻 Rodar Localmente

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) 3.x instalado
- Git
- Chrome (para web) ou Android/iOS conectado

### Passos

```bash
# Clonar o repositório
git clone https://github.com/rebcm/game.git
cd game

# Instalar dependências
flutter pub get

# Rodar no Chrome
flutter run -d chrome

# Rodar no Android
flutter run

# Checar erros
dart analyze
```

### Build

```bash
# Android APK (instalar direto)
flutter build apk --release

# Android AAB (Google Play)
flutter build appbundle

# Web (Cloudflare Pages)
flutter build web --release
```

---

## 🗂️ Estrutura do Código

```
lib/
├── main.dart                           # Entrada: orientação paisagem, modo imersivo
├── app/
│   └── app.dart                        # MaterialApp + ChangeNotifierProvider
├── blocos/
│   └── tipo_bloco.dart                 # Enum TipoBloco + extensões (cor, nome, física)
├── config/
│   └── constantes.dart                 # Configurações globais do jogo
├── jogo/
│   ├── estado_jogo.dart                # Estado global (EstadoJogo extends ChangeNotifier)
│   └── renderizador_isometrico.dart    # CustomPainter: projeção 2.5D isométrica
├── mundo/
│   ├── posicao3d.dart                  # Coordenada 3D inteira (x, y, z)
│   ├── chunk.dart                      # Chunk 16×16×64 com serialização JSON
│   ├── gerador.dart                    # Gerador procedural (heightmap + árvores)
│   └── mundo.dart                      # Cache de chunks + persistência local
├── personagem/
│   └── rebeca.dart                     # Personagem: posição, inventário, Canvas render
└── ui/
    ├── tela_inicio.dart                # Tela inicial animada
    ├── tela_jogo.dart                  # Loop principal: teclado, gestos, toque
    └── hud.dart                        # HUD: coordenadas, hotbar, inventário modal
```

---

## ⚙️ CI/CD

Pipeline automático no GitHub Actions — roda **todo dia às 20:00 BRT (23:00 UTC)**:

| Job | Runner | Saída |
|-----|--------|-------|
| Android | ubuntu-latest | APK + AAB assinados |
| iOS | macos-latest | Build não assinado |
| Web | ubuntu-latest | Deploy → Cloudflare Pages |
| Release | ubuntu-latest | GitHub Release com artefatos |

Também roda em todo push para `main`.

**Secrets configurados no GitHub:**

| Secret | Descrição |
|--------|-----------|
| `CLOUDFLARE_API_TOKEN` | Deploy automático no Cloudflare Pages ✅ |
| `ANDROID_KEYSTORE_B64` | Keystore em Base64 para assinar APK |
| `ANDROID_KEY_ALIAS` | Alias da chave Android |
| `ANDROID_STORE_PASSWORD` | Senha do keystore |
| `ANDROID_KEY_PASSWORD` | Senha da chave |

---

## 🛠️ Tecnologias

| Tecnologia | Para que serve |
|-----------|----------------|
| Flutter 3.x | Framework multiplataforma (Android, iOS, Web) |
| Dart 3.x | Linguagem de programação |
| Provider | Gerenciamento de estado (ChangeNotifier) |
| SharedPreferences | Persistência local do mundo salvo |
| CustomPainter | Renderização isométrica 2.5D |
| Cloudflare Pages | Hospedagem web gratuita |
| GitHub Actions | CI/CD automático diário |

---

## 🗺️ Roadmap

### ✅ v0.1 — Fundação
- [x] Renderização isométrica com 3 faces por bloco
- [x] Mundo procedural (chunks + árvores)
- [x] Personagem Rebeca com inventário criativo completo
- [x] Colocar e remover blocos
- [x] Controles teclado (WASD + Espaço + Shift + E + 1-9)
- [x] Controles touch (arrastar, pinça, toque)
- [x] HUD: coordenadas, hotbar, inventário modal
- [x] Tela inicial animada com campo de nome do mundo
- [x] CI/CD diário para Android, iOS e Web
- [x] Deploy automático Cloudflare Pages

### 🚧 v0.2 — Persistência
- [x] Salvar o mundo localmente (SharedPreferences)
- [x] Restaurar o mundo na próxima sessão
- [ ] Múltiplos slots de mundo salvo
- [ ] Texturas pixel art nos blocos
- [ ] Sons ao colocar e remover blocos

### 🔮 v0.3 — Polimento
- [ ] Animação da Rebeca caminhando
- [ ] Modo noturno decorativo (ciclo dia/noite)
- [ ] Exportar screenshot do mundo
- [ ] Undo/Redo de blocos (Ctrl+Z / Ctrl+Y)
- [ ] Ferramenta de preenchimento em área

### 🌐 v0.4 — Backend
- [ ] Sincronizar mundo via Cloudflare Workers
- [ ] Múltiplos mundos na nuvem
- [ ] Compartilhar mundo por link

---

## 📄 Autoria e Direitos

**Autora:** Rebeca Alves Moreira  
**Todos os direitos reservados.**  
Este projeto é pessoal. Não autorizado para redistribuição comercial.

---

*Feito com 💚 e Flutter*
