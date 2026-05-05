import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/jogo/construcao_criativa.dart';
import 'package:rebcm/personagem/rebeca.dart';

class ControlesOverlay extends StatefulWidget {
  final ConstrucaoCriativa game;
  const ControlesOverlay({super.key, required this.game});

  @override
  State<ControlesOverlay> createState() => _ControlesOverlayState();
}

class _ControlesOverlayState extends State<ControlesOverlay> {
  Offset _joyBase = Offset.zero;
  Offset _joyKnob = Offset.zero;
  bool _joyActive = false;
  int _slotAtual = 0;

  static const double _maxR = 48.0;
  static const double _joySize = 120.0;
  static const List<String> _camLabels = ['NE', 'SE', 'SW', 'NW'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Joystick bottom-left
        Positioned(left: 16, bottom: 80, child: _buildJoystick()),

        // Action buttons bottom-right
        Positioned(right: 16, bottom: 120, child: _buildAcoes()),

        // Fly buttons top-right (logo abaixo do menu de save)
        Positioned(right: 16, top: 96, child: _buildVooButtons()),

        // Save / Load buttons top-right
        Positioned(right: 16, top: 16, child: _buildMenuTopo()),

        // Camera rotate bottom-left below joystick
        Positioned(left: 16, bottom: 20, child: _buildCamButton()),

        // Hotbar bottom-center
        Positioned(bottom: 12, left: 0, right: 0, child: _buildHotbar()),

        // HUD top-left
        Positioned(top: 12, left: 12, child: _buildHud()),

        // Toast central (top) — feedback de save/load
        Positioned(
          top: 12,
          left: 0,
          right: 0,
          child: Center(child: _buildToast()),
        ),
      ],
    );
  }

  Widget _buildMenuTopo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _miniBotao('💾', 'Salvar', Colors.indigo, () async {
              await widget.game.salvarAgora();
              setState(() {});
            }),
            const SizedBox(width: 6),
            _miniBotao('📂', 'Carregar', Colors.teal, () async {
              await widget.game.carregarAgora();
              setState(() {});
            }),
          ],
        ),
        const SizedBox(height: 6),
        _miniBotao('🗑', 'Apagar Save', Colors.red.shade700, () async {
          await widget.game.apagarSave();
          setState(() {});
        }, wide: true),
      ],
    );
  }

  Widget _miniBotao(String icon, String label, Color cor, VoidCallback onTap,
      {bool wide = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: wide ? 122 : 58,
        height: 36,
        decoration: BoxDecoration(
          color: cor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white30, width: 1.0),
          boxShadow: const [BoxShadow(color: Color(0x44000000), blurRadius: 3)],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 15)),
            const SizedBox(width: 4),
            Text(label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildToast() {
    return ValueListenableBuilder<String?>(
      valueListenable: widget.game.mensagem,
      builder: (ctx, msg, _) {
        if (msg == null || msg.isEmpty) return const SizedBox.shrink();
        return AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: Text(
              msg,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildJoystick() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (d) => setState(() {
        _joyBase = d.localPosition;
        _joyKnob = d.localPosition;
        _joyActive = true;
      }),
      onPanUpdate: (d) {
        final delta = d.localPosition - _joyBase;
        final dist = delta.distance.clamp(0.0, _maxR);
        final dir = dist > 0 ? delta / delta.distance : Offset.zero;
        setState(() => _joyKnob = _joyBase + dir * dist);
        widget.game.setJoystick(dir.dx, dir.dy);
      },
      onPanEnd: (_) {
        setState(() {
          _joyKnob = _joyBase;
          _joyActive = false;
        });
        widget.game.setJoystick(0, 0);
      },
      child: SizedBox(
        width: _joySize,
        height: _joySize,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.28),
                  border: Border.all(color: Colors.white38, width: 2),
                ),
              ),
            ),
            Positioned(
              left: (_joyActive ? _joyKnob.dx : _joySize / 2) - 22,
              top: (_joyActive ? _joyKnob.dy : _joySize / 2) - 22,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.65),
                  boxShadow: const [BoxShadow(blurRadius: 6, color: Color(0x44000000))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcoes() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _botaoSimples('🧱', 'Colocar', Colors.green, widget.game.colocarBloco),
        const SizedBox(height: 10),
        GestureDetector(
          onLongPressStart: (_) => widget.game.iniciarQuebra(),
          onLongPressEnd: (_) => widget.game.pararQuebra(),
          onTap: widget.game.quebrarBlocoImediato,
          child: _botaoWidget('⛏', 'Quebrar', Colors.orange),
        ),
      ],
    );
  }

  Widget _buildVooButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTapDown: (_) => widget.game.setVertical(1.0),
          onTapUp: (_) => widget.game.setVertical(0),
          onTapCancel: () => widget.game.setVertical(0),
          child: _botaoWidget('▲', 'Subir', Colors.lightBlue.shade300),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTapDown: (_) => widget.game.setVertical(-1.0),
          onTapUp: (_) => widget.game.setVertical(0),
          onTapCancel: () => widget.game.setVertical(0),
          child: _botaoWidget('▼', 'Descer', Colors.lightBlue.shade300),
        ),
      ],
    );
  }

  Widget _buildCamButton() {
    return GestureDetector(
      onTap: () {
        widget.game.rotacionarCamera();
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔄', style: TextStyle(fontSize: 14)),
            const SizedBox(width: 4),
            Text(
              _camLabels[widget.game.camAngle],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHud() {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 250)),
      builder: (ctx, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.game.coordenadas,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              'Criativo · Câm: ${_camLabels[widget.game.camAngle]}  R=Rodar',
              style: const TextStyle(color: Colors.white60, fontSize: 9),
            ),
            Text(
              '🕒 ${widget.game.textoTempoDia}',
              style: const TextStyle(
                color: Colors.amberAccent,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotbar() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(Rebeca.hotbar.length, (i) {
            final bloco = Rebeca.hotbar[i];
            final sel = i == _slotAtual;
            return GestureDetector(
              onTap: () {
                setState(() => _slotAtual = i);
                widget.game.selecionarSlot(i);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: sel ? 50 : 44,
                height: sel ? 50 : 44,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: sel
                      ? Colors.white.withOpacity(0.28)
                      : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: sel ? Colors.white : Colors.white30,
                    width: sel ? 2.0 : 1.0,
                  ),
                  boxShadow: sel
                      ? [const BoxShadow(color: Color(0x44FFFFFF), blurRadius: 6)]
                      : null,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: bloco.corTopo,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: Colors.black26, width: 0.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(_icone(bloco),
                            style: const TextStyle(fontSize: 15)),
                      ),
                      if (sel)
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            bloco.nome,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _botaoSimples(String icon, String label, Color cor, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: _botaoWidget(icon, label, cor));
  }

  Widget _botaoWidget(String icon, String label, Color cor) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: cor.withOpacity(0.65),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white30, width: 1.5),
        boxShadow: const [BoxShadow(color: Color(0x44000000), blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          Text(label,
              style: const TextStyle(
                  color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _icone(TipoBloco b) {
    switch (b) {
      case TipoBloco.grama:    return '🌿';
      case TipoBloco.terra:    return '🟫';
      case TipoBloco.pedra:    return '🪨';
      case TipoBloco.areia:    return '🏖';
      case TipoBloco.madeira:  return '🪵';
      case TipoBloco.tijolo:   return '🧱';
      case TipoBloco.ouro:     return '🥇';
      case TipoBloco.diamante: return '💎';
      default: return '■';
    }
  }
}
