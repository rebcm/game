/// Conditional entry point para SFX.
///
/// Em web, usa `dart:web_audio` para sintetizar tons curtos sem assets.
/// Em mobile/desktop, é no-op (poderia usar `audioplayers` futuramente).
export 'audio_stub.dart' if (dart.library.html) 'audio_web.dart';
