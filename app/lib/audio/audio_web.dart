// ignore_for_file: deprecated_member_use
import 'dart:html' as html;

/// SFX em web: despacha CustomEvent('rebcm-sfx', detail: <nome>) que o
/// `<script>` em web/index.html captura e toca via Web Audio API.
class Audio {
  static void _disparar(String nome) {
    try {
      final ev = html.CustomEvent('rebcm-sfx', detail: nome);
      html.window.dispatchEvent(ev);
    } catch (_) {/* engole */}
  }

  static void quebrar() => _disparar('quebrar');
  static void colocar() => _disparar('colocar');
  static void atacar() => _disparar('atacar');
  static void hit() => _disparar('hit');
  static void passo() => _disparar('passo');
  static void comer() => _disparar('comer');
  static void respawn() => _disparar('respawn');
}
