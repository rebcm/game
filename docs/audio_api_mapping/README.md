# Mapeamento de APIs de Áudio por Plataforma

Este documento descreve as diferenças de implementação de áudio entre Flutter Web (Web Audio API), Android (AudioTrack/MediaPlayer) e iOS (AVAudioPlayer) para as versões listadas na matriz.

## Matriz de Suporte

| Plataforma | Versão Mínima | API de Áudio Utilizada |
| --- | --- | --- |
| Flutter Web | - | Web Audio API |
| Android | - | AudioTrack/MediaPlayer |
| iOS | - | AVAudioPlayer |

## Diferenças de Implementação

### Flutter Web

* Utiliza a Web Audio API para reprodução de áudio.
* Suporte a formatos de áudio: MP3, WAV, OGG.

### Android

* Utiliza AudioTrack e MediaPlayer para reprodução de áudio.
* Suporte a formatos de áudio: MP3, WAV, OGG, AAC.

### iOS

* Utiliza AVAudioPlayer para reprodução de áudio.
* Suporte a formatos de áudio: MP3, WAV, AAC, ALAC.

## Considerações de Implementação

* É necessário tratar as diferenças de suporte a formatos de áudio entre as plataformas.
* A implementação deve ser feita de forma a garantir a compatibilidade entre as plataformas.

