/// Conditional entry point para entrar em fullscreen e travar landscape.
///
/// Em Flutter web, importa a implementação que usa `dart:html`. Em
/// mobile/desktop nativos, vira no-op.
export 'web_fullscreen_stub.dart'
    if (dart.library.html) 'web_fullscreen_web.dart';
