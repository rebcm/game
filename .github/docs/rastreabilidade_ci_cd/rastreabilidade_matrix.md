# Matriz de Rastreabilidade CI/CD

## Introdução

Este documento visa estabelecer uma matriz de rastreabilidade entre os itens de documentação e os steps do pipeline de CI/CD do projeto `rebcm/game`. A matriz permitirá verificar a conformidade de cada item documentado com os respectivos steps do pipeline.

## Matriz de Rastreabilidade

| Item de Documentação | Localização | Step do Pipeline | Conformidade |
| --- | --- | --- | --- |
| Critérios de Aceitação do Passdriver Flutter | ./passdriver_flutter_criterios/criterios_aceitacao.md | build e test | Conforme |
| Validação de Integração do Passdriver Flutter | ./passdriver_flutter_integration_validation/criterios_aceitacao.md | integration_test | Conforme |
| Configuração de Notificação | ./notification_configuration.md | deploy | Conforme |
| Critérios de Aceitação do Pipeline de Deploy | ./pipeline_deploy_criterios.md | deploy | Conforme |
| Especificação de Movimentação do Jogador | ./player_movement_specification/player_movement_specification.md | build e test | Conforme |

## Conclusão

A matriz de rastreabilidade apresentada acima demonstra a conformidade dos principais itens de documentação com os steps do pipeline de CI/CD. Isso assegura que o projeto segue os critérios de aceitação definidos e que o pipeline está alinhado com as especificações do projeto.

