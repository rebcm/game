# Mapeamento de APIs de Áudio por Plataforma

Este documento visa mapear as diferenças de implementação de áudio entre Flutter Web (Web Audio API), Android (AudioTrack/MediaPlayer) e iOS (AVAudioPlayer) para as versões listadas na matriz.

## Matriz de Suporte

| Plataforma | Versão Mínima | API de Áudio         |
|------------|---------------|----------------------|
| Flutter Web| -             | Web Audio API        |
| Android    | -             | AudioTrack/MediaPlayer|
| iOS        | -             | AVAudioPlayer        |

## Diferenças de Implementação

### Flutter Web (Web Audio API)

* Utiliza a Web Audio API para reprodução de áudio.
* Suporte a áudio 3D e efeitos de áudio avançados.

### Android (AudioTrack/MediaPlayer)

* Utiliza AudioTrack para reprodução de áudio raw e MediaPlayer para reprodução de arquivos de mídia.
* Suporte a diferentes formatos de áudio.

### iOS (AVAudioPlayer)

* Utiliza AVAudioPlayer para reprodução de áudio.
* Suporte a diferentes formatos de áudio e controle de volume.

## Conclusão

As APIs de áudio variam significativamente entre as plataformas. Este mapeamento servirá como referência para futuras implementações de áudio no projeto.
