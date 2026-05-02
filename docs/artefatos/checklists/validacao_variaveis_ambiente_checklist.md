# Checklist de Validação de Variáveis de Ambiente

## Introdução
Este checklist visa garantir que as variáveis de ambiente estejam corretamente configuradas para os ambientes de staging e production.

## Itens de Verificação

1. **Variáveis de Ambiente no Wrangler.toml**
   - [ ] Verificar se o arquivo `wrangler.toml` existe.
   - [ ] Verificar se as variáveis de ambiente estão definidas para os ambientes de staging e production.
   - [ ] Validar os valores das variáveis de ambiente para cada ambiente.

2. **Configuração dos Ambientes**
   - [ ] Verificar se as variáveis de ambiente estão sendo utilizadas corretamente no código.
   - [ ] Validar se as variáveis de ambiente estão sendo carregadas corretamente nos respectivos ambientes.

## Critérios de Aceitação
- O arquivo `wrangler.toml` deve existir e estar configurado corretamente.
- As variáveis de ambiente devem estar definidas para os ambientes de staging e production.
- Os valores das variáveis de ambiente devem ser válidos e corretos para cada ambiente.
