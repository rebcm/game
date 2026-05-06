# 🧊 Construção Criativa — Versão Flutter 2D (Legado)

**Autora:** Rebeca Alves Moreira

> ⚠️ **Esta é a versão antiga em modo manutenção.** A versão atual em produção é Three.js, em [`../web3d/`](../web3d/).

---

## Sobre

Pasta `app/` contém o wrapper Flutter da versão 2D isométrica do jogo. O motor real fica em [`../lib/`](../lib/).

Esta versão segue as regras originais do projeto: **modo criativo puro**, sem mobs, sem morte, sem fome.

## Como rodar

```bash
flutter pub get
dart analyze --no-fatal-warnings
flutter run
```

## Build web

```bash
flutter build web --release --base-href /
# Output: app/build/web/
```

## Documentação

Veja `../README.md` para a documentação completa do projeto, incluindo a versão Three.js atual.
