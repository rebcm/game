# Mapeamento de APIs de Áudio

## Introdução

Este documento apresenta o mapeamento das APIs de áudio utilizadas pelo jogo em diferentes plataformas.

## APIs de Áudio por Plataforma

| Plataforma | API de Áudio Utilizada |
| --- | --- |
| Flutter Web | Web Audio API |
| Android | AudioTrack/MediaPlayer |
| iOS | AVAudioPlayer |

## Diferenças de Implementação

As principais diferenças na implementação das APIs de áudio entre as plataformas são:

- **Flutter Web**: Utiliza a Web Audio API para reprodução de áudio.
- **Android**: Utiliza AudioTrack para reprodução de áudio em baixa latência e MediaPlayer para reprodução de áudio em geral.
- **iOS**: Utiliza AVAudioPlayer para reprodução de áudio.

## Versões Suportadas

O jogo suporta as seguintes versões das plataformas:

- **Flutter Web**: Última versão estável
- **Android**: Versões 5.0 (API level 21) até a última versão estável
- **iOS**: Versões 11.0 até a última versão estável

## Compatibilidade

As APIs de áudio utilizadas são compatíveis com as versões suportadas das plataformas.
