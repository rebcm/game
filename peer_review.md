# 👥 Peer Review

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira

---

## 🎯 Objetivo

Define o padrão de revisão de código e conteúdo para o projeto.

---

## ✅ Critérios de Aprovação

### Código (`web3d/game.js`, `style.css`, `index.html`)

- [ ] **`node --check`** sobre `web3d/game.js` passa sem erros.
- [ ] **`scripts/test-web3d-precheck.js`** roda os 30 smoke tests sem falha.
- [ ] **Funcionalidade testada manualmente** no browser (desktop + celular se for mudança visual).
- [ ] **Sem TODO, FIXME, HACK** ou stubs no código adicionado.
- [ ] **Comentários explicam o "porquê"**, não o "o quê" óbvio.
- [ ] **Mudanças maiores** vêm com captura/vídeo de referência no PR.

### Conteúdo (textos, dicas, mensagens de UI)

- [ ] Texto em **português brasileiro** correto.
- [ ] Sem erros de ortografia/gramática.
- [ ] Tom adequado: simples e amigável (público-alvo é a Rebeca).
- [ ] Emojis usados com moderação e propósito.

### Documentação (`*.md`)

- [ ] **Reflete o estado atual** do projeto (versão Web3D, não Flutter).
- [ ] **Links válidos** entre documentos.
- [ ] **Autoria preservada**: "Rebeca Alves Moreira" presente.
- [ ] **Comandos testados** funcionam como descritos.

---

## 🚦 Aprovador

Para mudanças no jogo (`web3d/`):
- Game design: revisão da Rebeca ou responsável familiar.
- Técnica: qualquer agente/dev com acesso ao repo.

Para mudanças em docs:
- Texto: revisor de conteúdo.
- Estrutura: técnico.

---

## 🔁 Fluxo de PR

1. Branch novo a partir de `main`.
2. Commits atômicos com mensagens claras.
3. Push e abertura de PR.
4. CI/CD roda smoke tests automaticamente.
5. Pelo menos 1 aprovação humana.
6. Merge → deploy automático para https://construcao-criativa.pages.dev.

---

*Atualizado em maio/2026.*
