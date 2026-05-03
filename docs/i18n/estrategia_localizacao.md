# Estratégia de Internacionalização (i18n)

## Introdução

Este documento descreve a estratégia de internacionalização adotada para o projeto `rebcm/game`, focando na tradução de conteúdos para múltiplos idiomas no Flutter.

## Requisitos de Internacionalização

1. **Suporte a Múltiplos Idiomas**: O jogo deve suportar pelo menos dois idiomas: Português (pt-BR) e Inglês (en-US).
2. **Tradução de Conteúdo**: Todo o conteúdo textual exibido no jogo deve ser traduzido, incluindo dicas de construção, documentação de blocos, e descrições de SEO.
3. **Formatação de Conteúdo**: O formato dos arquivos de conteúdo deve ser mantido após a tradução.

## Implementação

### 1. Organização dos Arquivos de Tradução

- Criar uma pasta `docs/i18n` para armazenar arquivos relacionados à internacionalização.
- Dentro de `docs/i18n`, criar subpastas para cada idioma suportado (ex: `pt-BR`, `en-US`).

### 2. Tradução de Conteúdo

- **Dicas de Construção**: Traduzir `docs/dicas_construcao/conteudo_dicas.md` e `docs/dicas_construcao/conteudo_dicas_formatado.md` para os idiomas suportados.
  - Exemplo: `docs/i18n/pt-BR/dicas_construcao/conteudo_dicas.md` e `docs/i18n/en-US/dicas_construcao/conteudo_dicas.md`
- **Documentação de Blocos**: Traduzir `docs/bloco_documentation.json` para os idiomas suportados.
  - Exemplo: `docs/i18n/pt-BR/bloco_documentation.json` e `docs/i18n/en-US/bloco_documentation.json`
- **Descrições de SEO**: Traduzir `docs/seo/palavras-chave.md` para os idiomas suportados.
  - Exemplo: `docs/i18n/pt-BR/seo/palavras-chave.md` e `docs/i18n/en-US/seo/palavras-chave.md`

### 3. Atualização do `pubspec.yaml`

- Adicionar os arquivos traduzidos à seção `assets` do `pubspec.yaml`.

```yaml
flutter:
  assets:
    # Conteúdo existente...
    - docs/i18n/pt-BR/dicas_construcao/conteudo_dicas.md
    - docs/i18n/en-US/dicas_construcao/conteudo_dicas.md
    - docs/i18n/pt-BR/bloco_documentation.json
    - docs/i18n/en-US/bloco_documentation.json
    - docs/i18n/pt-BR/seo/palavras-chave.md
    - docs/i18n/en-US/seo/palavras-chave.md
```

### 4. Implementação da Lógica de Internacionalização no Flutter

- Utilizar o pacote `flutter_i18n` ou similar para carregar o conteúdo traduzido com base na localidade do dispositivo.

## Conclusão

A implementação da internacionalização no `rebcm/game` envolve a tradução de conteúdo, organização de arquivos, e atualização do `pubspec.yaml`. Isso permitirá que o jogo seja acessível a um público mais amplo.
