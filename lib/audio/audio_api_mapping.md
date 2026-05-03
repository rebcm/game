# Audio API Mapping

This document outlines the differences in audio API implementations across platforms.

## Web (Web Audio API)

* Uses Web Audio API for audio playback
* Implemented in `audio_web.dart`

## Android (AudioTrack/MediaPlayer)

* Uses AudioTrack or MediaPlayer for audio playback
* Implemented in `audio_android.dart`

## iOS (AVAudioPlayer)

* Uses AVAudioPlayer for audio playback
* Implemented in `audio_ios.dart`

## Comparison

The implementations differ in the following ways:

* Web: Uses Web Audio API, which provides a more modern and efficient audio processing pipeline.
* Android: Uses AudioTrack or MediaPlayer, depending on the specific requirements.
* iOS: Uses AVAudioPlayer, which provides a simple and easy-to-use API.

