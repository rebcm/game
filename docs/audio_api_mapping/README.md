# Mapeamento de APIs de Áudio por Plataforma

Este documento visa documentar as diferenças de implementação de áudio entre as plataformas suportadas pelo jogo.

## Plataformas Suportadas

* Flutter Web (Web Audio API)
* Android (AudioTrack/MediaPlayer)
* iOS (AVAudioPlayer)

## Implementação de Áudio por Plataforma

### Flutter Web

* Utiliza a Web Audio API para reprodução de áudio.
* Suporta formatos de áudio como MP3, WAV, etc.

### Android

* Utiliza a classe `AudioTrack` para reprodução de áudio em baixa latência.
* Utiliza a classe `MediaPlayer` para reprodução de áudio em geral.
* Suporta formatos de áudio como MP3, WAV, etc.

### iOS

* Utiliza a classe `AVAudioPlayer` para reprodução de áudio.
* Suporta formatos de áudio como MP3, WAV, etc.

## Diferenças de Implementação

| Plataforma | API de Áudio | Formatos Suportados |
| --- | --- | --- |
| Flutter Web | Web Audio API | MP3, WAV, etc. |
| Android | AudioTrack/MediaPlayer | MP3, WAV, etc. |
| iOS | AVAudioPlayer | MP3, WAV, etc. |

## Conclusão

As diferenças de implementação de áudio entre as plataformas suportadas são significativas. É importante considerar essas diferenças ao desenvolver o jogo para garantir uma experiência de áudio consistente em todas as plataformas.
