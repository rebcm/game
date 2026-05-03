# Mapeamento de APIs de Áudio por Plataforma

Este documento visa mapear as diferenças de implementação de áudio entre Flutter Web (Web Audio API), Android (AudioTrack/MediaPlayer) e iOS (AVAudioPlayer) para as versões listadas na matriz.

## Introdução

O jogo é desenvolvido em Flutter e precisa suportar diferentes plataformas, incluindo Web, Android e iOS. Cada plataforma tem sua própria API de áudio, o que pode levar a diferenças na implementação.

## Mapeamento de APIs

### Flutter Web (Web Audio API)

* Utiliza a Web Audio API para reprodução de áudio.
* Suporta formatos de áudio como MP3, WAV, etc.

### Android (AudioTrack/MediaPlayer)

* Utiliza AudioTrack para reprodução de áudio em baixa latência.
* Utiliza MediaPlayer para reprodução de áudio em geral.
* Suporta formatos de áudio como MP3, WAV, etc.

### iOS (AVAudioPlayer)

* Utiliza AVAudioPlayer para reprodução de áudio.
* Suporta formatos de áudio como MP3, WAV, etc.

## Diferenças de Implementação

| Plataforma | API de Áudio | Formatos Suportados | Latência |
| --- | --- | --- | --- |
| Flutter Web | Web Audio API | MP3, WAV, etc. | Variável |
| Android | AudioTrack/MediaPlayer | MP3, WAV, etc. | Baixa (AudioTrack) |
| iOS | AVAudioPlayer | MP3, WAV, etc. | Variável |

## Conclusão

O mapeamento das APIs de áudio por plataforma é fundamental para entender as diferenças de implementação e garantir que o jogo seja compatível com diferentes plataformas.

