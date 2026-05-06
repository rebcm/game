# ✅ Checklist de QA da Documentação

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira

Critérios para validar qualquer arquivo `.md` antes de mergear.

---

## 📋 Critérios Obrigatórios

| # | Critério | Como verificar |
|---|----------|----------------|
| 1 | **Reflete o estado atual** | Versão atual é Web3D (Three.js); não falar de PassDriver, OpenStreetMap, ou Flutter como única tecnologia |
| 2 | **Em português brasileiro** | Sem trechos em inglês exceto APIs ou termos técnicos consagrados |
| 3 | **Autoria preservada** | "Rebeca Alves Moreira" mencionada quando relevante |
| 4 | **Links válidos** | Caminhos relativos resolvem para arquivos existentes |
| 5 | **Comandos funcionam** | Comandos shell de exemplo testados localmente |
| 6 | **Formatação consistente** | Headers em ordem hierárquica, listas indentadas, tabelas alinhadas |
| 7 | **Sem TODO ou seções vazias** | Conteúdo concreto, não placeholder |
| 8 | **Ortografia correta** | Sem typos óbvios |

---

## 🛠 Validação automática

Por enquanto, validação é manual via review humana. No futuro pode-se adicionar:

- `markdownlint` no CI/CD.
- Link checker (`lychee` ou `markdown-link-check`).
- Spell checker em PT-BR.

---

## 📚 Documentos Críticos

Estes precisam estar **sempre atualizados**:

- [`README.md`](README.md) — visão geral pública.
- [`AGENTS.md`](AGENTS.md) — regras para agentes de IA.
- [`ARCHITECTURE.md`](ARCHITECTURE.md) — arquitetura técnica.
- [`docs/walkthrough.md`](docs/walkthrough.md) — guia jogável.
- [`docs/SETUP.md`](docs/SETUP.md) — setup de dev.
- [`docs/deploy/procedimento-deploy.md`](docs/deploy/procedimento-deploy.md) — fluxo de deploy.
- [`docs/CLAUDE.md`](docs/CLAUDE.md) — contexto para agentes IA.
- [`docs/blocos/README.md`](docs/blocos/README.md) — catálogo de blocos.
- [`docs/biomas.md`](docs/biomas.md) — geração do mundo.

---

## 📂 Documentos Legados

Arquivos em `assets/docs/`, `docs/checklists/*`, `docs/criterios_aceitacao/*`, e diversos sub-diretórios contêm **checklists e templates herdados** de fases anteriores do projeto. Eles não são mais críticos para o jogo, mas ficam no repo como histórico de processo. Não bloqueiam mergeações novos.

---

*Atualizado em maio/2026.*
