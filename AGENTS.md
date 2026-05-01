# AGENTS.md — Instruções para Agentes de Desenvolvimento

**Projeto:** Construção Criativa da Rebeca  
**Autora:** Rebeca Alves Moreira  
**Repositório:** https://github.com/rebcm/game

## Missão

Evoluir o jogo Flutter de blocos voxel modo criativo. O jogo deve permanecer simples, estável e divertido. Não adicionar complexidade desnecessária.

## Regras Invioláveis

1. **Modo criativo puro.** Nunca adicionar survivel, saúde, fome, morte, drops ou mobs.
2. **Um único bioma.** Nunca adicionar biomas, portais ou fases adicionais.
3. **Sem NPCs ou monstros.** O único personagem é a Rebeca.
4. **Código que funciona.** Nenhuma implementação parcial, TODO, ou stub aceito.
5. **Dart analyze sem erros.** Executar `dart analyze` antes de commitar; zero erros exigidos.
6. **Autoria preservada.** `Rebeca Alves Moreira` deve aparecer em Constantes.autora.

## Comandos Essenciais

```bash
# Instalar dependências
flutter pub get

# Verificar erros
dart analyze

# Rodar em modo debug
flutter run -d chrome          # Web
flutter run                    # Android/iOS conectado

# Build release
flutter build apk --release    # Android APK
flutter build appbundle        # Android AAB
flutter build web --release    # Web
flutter build ios --release    # iOS (requer macOS + certs)

# Formatar código
dart format lib/
```

## Estrutura do Código

```
lib/
├── blocos/tipo_bloco.dart      # Adicionar novos blocos AQUI
├── mundo/gerador.dart          # Ajustar geração de terreno AQUI
├── personagem/rebeca.dart      # Visual/comportamento da Rebeca AQUI
├── jogo/renderizador_isometrico.dart  # Renderer AQUI
├── ui/hud.dart                 # HUD, hotbar, inventário AQUI
└── config/constantes.dart      # Tuning de valores AQUI
```

## Como Adicionar um Novo Bloco

1. Adicionar ao enum `TipoBloco` em `lib/blocos/tipo_bloco.dart`
2. Adicionar `nome`, `cor` e propriedades (`solido`, `transparente`, `emiteLuz`) nas extensões
3. Se adicionar textura: colocar em `assets/blocos/<nome>.png` e declarar em `pubspec.yaml`
4. O bloco aparece automaticamente no inventário criativo (via `TipoBloco.values`)

## Como Melhorar o Renderizador

- O renderer está em `lib/jogo/renderizador_isometrico.dart`
- Cada bloco renderiza 3 faces: topo, esquerda, direita
- Projeção: `screenX = (x - z) * (TAMANHO/2)`, `screenY = (x+z) * (TAMANHO/4) - y * (TAMANHO/2)`
- Para texturas: substituir `Paint.color` por `Paint()..shader` com `ImageShader`
- Não alterar a ordem de renderização (y crescente, z crescente) — é essencial para depth sorting

## Como Ajustar o Mundo

- Geração em `lib/mundo/gerador.dart`
- Heightmap usa `sin + cos` para ondulação natural
- Árvores são colocadas com probabilidade por chunk
- Para novos elementos (lagos, montanhas): modificar `GeradorMundo.gerarChunk`
- Nunca remover a camada de grama/terra/pedra — é a fundação do terreno

## Regras de Commit

```
feat: descrição curta da feature
fix: descrição do bug corrigido
perf: melhoria de performance
refactor: refatoração sem mudança de comportamento
```

- Commits em português ou inglês, mensagem curta (<72 chars)
- Sempre rodar `dart analyze` antes de commitar (zero erros)
- Não commitar arquivos de build (`build/`, `.dart_tool/`)

## CI/CD

O workflow `.github/workflows/release.yml` roda diariamente às 20:00 BRT (23:00 UTC):

1. **Android**: APK + AAB assinados (requer secrets: `ANDROID_KEYSTORE_B64`, `ANDROID_KEY_ALIAS`, `ANDROID_STORE_PASSWORD`, `ANDROID_KEY_PASSWORD`)
2. **iOS**: Build não assinado (requer macOS runner; assinatura via Fastlane futuramente)
3. **Web**: Deploy automático para Cloudflare Pages (requer: `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID`)

Releases são criados automaticamente com tag `v<versão>-daily-<data>`.

## Cloudflare Workers (Backend Opcional)

- URL da API: `https://construcao-criativa.workers.dev`
- Código do worker: diretório `workers/` (a criar)
- O jogo funciona 100% offline sem o backend
- O backend serve apenas para sync de mundos entre dispositivos

## O Que Nunca Fazer

- Nunca adicionar modo survivel
- Nunca adicionar receitas de crafting
- Nunca adicionar hunger/health bar
- Nunca adicionar mobs, animais ou NPCs
- Nunca adicionar múltiplos biomas ou portais
- Nunca remover blocos já existentes (apenas adicionar)
- Nunca alterar o nome da autora `Rebeca Alves Moreira`
- Nunca commitar com `dart analyze` reportando erros
