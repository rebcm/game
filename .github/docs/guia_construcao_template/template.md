# Guia de Construção

Este guia fornece dicas e instruções para construção no jogo.

## Dicas de Construção

1. **Use o grid para alinhar blocos**: O grid ajuda a manter a estrutura organizada.
2. **Planeje antes de construir**: Ter um plano ajuda a evitar erros e retrabalho.
3. **Use cores para diferenciar áreas**: Cores podem ajudar a distinguir diferentes partes da construção.

## Templates de Construção

### Template de Casa Simples

- Use blocos de base para a fundação.
- Adicione paredes com blocos de parede.
- Cubra com blocos de teto.

### Template de Jardim

- Use blocos de grama para o chão.
- Adicione plantas e flores.
- Crie caminhos com blocos de pedra.

## Exemplos de Construção

### Exemplo de Código para Construção

```dart
// Exemplo de como criar uma estrutura simples
void criarEstrutura() {
  // Crie a fundação
  for (int x = 0; x < 5; x++) {
    for (int z = 0; z < 5; z++) {
      // Coloque blocos de base
      mundo.setBloco(x, 0, z, Bloco.base);
    }
  }
  
  // Adicione paredes
  for (int y = 1; y < 5; y++) {
    for (int x = 0; x < 5; x++) {
      mundo.setBloco(x, y, 0, Bloco.parede);
      mundo.setBloco(x, y, 4, Bloco.parede);
    }
    for (int z = 1; z < 4; z++) {
      mundo.setBloco(0, y, z, Bloco.parede);
      mundo.setBloco(4, y, z, Bloco.parede);
    }
  }
}
```

## Checklist de Construção

- [ ] Planeje a construção
- [ ] Use o grid para alinhar
- [ ] Adicione detalhes finais

{"pt-BR": "Tradução para pt-BR"}
