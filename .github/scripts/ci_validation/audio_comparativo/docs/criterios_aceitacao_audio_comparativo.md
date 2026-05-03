# Critérios de Aceitação para Comparativo de Áudio

Este documento define os critérios de aceitação para o comparativo de comportamento do áudio no jogo em diferentes plataformas (Android e iOS) e cenários (modo silencioso e alternância de hardware).

## Cenários de Teste

1. **Modo Silencioso**
   - Verificar se o áudio é silenciado corretamente em ambas as plataformas.
   
2. **Alternância de Hardware**
   - Verificar o comportamento do áudio ao alternar entre diferentes dispositivos de saída (e.g., fones de ouvido e alto-falantes) em ambas as plataformas.

## Comportamento Esperado

| Plataforma | Cenário | Comportamento Esperado |
|------------|---------|------------------------|
| Android    | Modo Silencioso | Áudio silenciado |
| Android    | Alternância de Hardware | Áudio continua a tocar após alternância |
| iOS        | Modo Silencioso | Áudio silenciado |
| iOS        | Alternância de Hardware | Áudio continua a tocar após alternância |

## Critérios de Aceitação

1. O áudio deve ser silenciado quando o dispositivo estiver no modo silencioso em ambas as plataformas.
2. O áudio deve continuar a tocar sem interrupções ao alternar entre diferentes dispositivos de saída em ambas as plataformas.

## Metodologia de Teste

1. Executar o jogo em dispositivos Android e iOS.
2. Testar o modo silencioso ativando o modo silencioso do dispositivo e verificar se o áudio é silenciado.
3. Testar a alternância de hardware conectando e desconectando dispositivos de saída (e.g., fones de ouvido) e verificar se o áudio continua a tocar sem interrupções.

## Aprovação

Os critérios de aceitação são considerados aprovados se todos os cenários de teste forem concluídos com sucesso em ambas as plataformas.
