# Checklist de Validação de Onboarding

## Introdução

Este documento visa criar um checklist para validação do processo de onboarding dos desenvolvedores no projeto `rebcm/game`. O objetivo é identificar pontos de dúvida ou erro durante o processo de configuração e execução do projeto, permitindo assim a melhoria contínua do guia de onboarding.

## Checklist

1. **Configuração Inicial**
   - [ ] Clonar o repositório corretamente
   - [ ] Configurar as variáveis de ambiente (.env)
   - [ ] Executar o comando de instalação de dependências (`flutter pub get`)

2. **Execução do Projeto**
   - [ ] Compilar e executar o projeto com sucesso (`flutter run`)
   - [ ] Verificar se o jogo está funcionando corretamente

3. **Testes e Validações**
   - [ ] Executar os testes unitários (`flutter test`)
   - [ ] Executar os testes de integração (`flutter drive --target=integration_test/<nome_do_teste>.dart`)

4. **Dúvidas ou Erros**
   - [ ] Identificar e documentar qualquer dúvida ou erro encontrado durante o processo

## Formulário de Feedback

Para facilitar a coleta de informações, o desenvolvedor deve preencher o seguinte formulário após concluir o checklist:

- Qual foi o passo mais difícil ou confuso durante o onboarding?
- Houve algum erro ou problema que você não conseguiu resolver facilmente? Se sim, descreva.
- Sugestões para melhorar o guia de onboarding.

