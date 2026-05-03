# Mapeamento de APIs de Áudio por Plataforma

Este documento visa mapear as diferenças de implementação de áudio entre as plataformas suportadas pelo jogo.

## Plataformas Suportadas

* Flutter Web (Web Audio API)
* Android (AudioTrack/MediaPlayer)
* iOS (AVAudioPlayer)

## Implementação de Áudio por Plataforma

### Flutter Web

A implementação de áudio no Flutter Web utiliza a Web Audio API.

* **Características:**
 + Suporte a áudio em tempo real
 + Controle de volume e pitch
 + Suporte a efeitos de áudio
* **Limitações:**
 + Dependência da implementação do navegador

### Android

A implementação de áudio no Android utiliza AudioTrack e MediaPlayer.

* **Características:**
 + Suporte a áudio em tempo real
 + Controle de volume e pitch
 + Suporte a efeitos de áudio
* **Limitações:**
 + Diferenças de implementação entre versões do Android

### iOS

A implementação de áudio no iOS utiliza AVAudioPlayer.

* **Características:**
 + Suporte a áudio em tempo real
 + Controle de volume e pitch
 + Suporte a efeitos de áudio
* **Limitações:**
 + Dependência da versão do iOS

## Comparação entre Plataformas

| Característica | Flutter Web | Android | iOS |
| --- | --- | --- | --- |
| Suporte a áudio em tempo real | Sim | Sim | Sim |
| Controle de volume e pitch | Sim | Sim | Sim |
| Suporte a efeitos de áudio | Sim | Sim | Sim |

## Conclusão

As implementações de áudio nas diferentes plataformas apresentam características e limitações distintas. É fundamental considerar essas diferenças ao desenvolver o jogo para garantir uma experiência consistente em todas as plataformas.
