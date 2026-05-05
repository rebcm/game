// ignore_for_file: deprecated_member_use
import 'dart:html' as html;

/// Pede ao browser para entrar em fullscreen e travar landscape. Browsers
/// só permitem em resposta a um gesto do usuário; falhas são engolidas.
void entrarTelaCheia() {
  try {
    final el = html.document.documentElement;
    if (el != null) {
      final fut = el.requestFullscreen();
      // Em alguns navegadores requestFullscreen retorna Future; engolimos
      // qualquer rejeição silenciosamente.
      // ignore: unawaited_futures
      fut.catchError((_) {});
    }
  } catch (_) {/* engole */}

  // Lock orientation só funciona após fullscreen, e apenas em certos
  // browsers móveis. Falhas silenciosas são esperadas.
  try {
    final orientation = html.window.screen?.orientation;
    // ignore: avoid_dynamic_calls
    final lockFn = (orientation as dynamic)?.lock as Function?;
    if (lockFn != null) {
      try {
        lockFn('landscape');
      } catch (_) {/* engole */}
    }
  } catch (_) {/* engole */}
}
