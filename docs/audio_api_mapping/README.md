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
 + Suporte a áudio em formato OGG e MP3 (com limitações)
 + Controle de volume e playback
 + Suporte a efeitos de áudio via nós de áudio

### Android

A implementação de áudio no Android utiliza a classe `AudioTrack` ou `MediaPlayer`.

* **Características:**
 + Suporte a vários formatos de áudio (MP3, AAC, OGG, etc.)
 + Controle de volume e playback
 + Suporte a efeitos de áudio via `AudioEffect`

### iOS

A implementação de áudio no iOS utiliza a classe `AVAudioPlayer`.

* **Características:**
 + Suporte a vários formatos de áudio (MP3, AAC, etc.)
 + Controle de volume e playback
 + Suporte a efeitos de áudio via `AVAudioUnit`

## Diferenças de Implementação

| Característica | Flutter Web | Android | iOS |
| --- | --- | --- | --- |
| Formatos de Áudio Suportados | OGG, MP3 (limitado) | MP3, AAC, OGG, etc. | MP3, AAC, etc. |
| Controle de Volume | Sim | Sim | Sim |
| Efeitos de Áudio | Sim (via nós de áudio) | Sim (via `AudioEffect`) | Sim (via `AVAudioUnit`) |

## Conclusão

As implementações de áudio variam entre as plataformas, mas todas oferecem suporte básico a controle de volume e playback. É importante considerar essas diferenças ao implementar funcionalidades de áudio no jogo.
