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
  static const double _maxR = 50.0;
  static const double _joySize = 120.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(left: 20, bottom: 80, child: _buildJoystick()),
        Positioned(right: 20, bottom: 160, child: _buildBotoes()),
        Positioned(bottom: 20, left: 0, right: 0, child: _buildHotbar()),
      ],
    );
  }

  Widget _buildJoystick() {
    return GestureDetector(
      onPanStart: (d) => setState(() { _joyBase = d.localPosition; _joyKnob = d.localPosition; _joyActive = true; }),
      onPanUpdate: (d) {
        final delta = d.localPosition - _joyBase;
        final dist = delta.distance.clamp(0.0, _maxR);
        final dir = dist > 0 ? delta / delta.distance : Offset.zero;
        setState(() => _joyKnob = _joyBase + dir * dist);
        widget.game.setJoystick(dir.dx, dir.dy);
      },
      onPanEnd: (_) {
        setState(() { _joyKnob = _joyBase; _joyActive = false; });
        widget.game.setJoystick(0, 0);
      },
      child: SizedBox(width: _joySize, height: _joySize,
        child: Stack(children: [
          Positioned.fill(child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.15), border: Border.all(color: Colors.white30, width: 2)))),
          Positioned(
            left: _joyActive ? _joyKnob.dx - 20 : _joySize / 2 - 20,
            top: _joyActive ? _joyKnob.dy - 20 : _joySize / 2 - 20,
            child: Container(width: 40, height: 40, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white54)),
          ),
        ]),
      ),
    );
  }

  Widget _buildBotoes() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _botaoVertical('▲', 1.0),
      const SizedBox(height: 8),
      Row(mainAxisSize: MainAxisSize.min, children: [
        _botaoAcao('⛏', widget.game.quebrarBloco, Colors.orange),
        const SizedBox(width: 8),
        _botaoAcao('🧱', widget.game.colocarBloco, Colors.green),
      ]),
      const SizedBox(height: 8),
      _botaoVertical('▼', -1.0),
    ]);
  }

  Widget _botaoVertical(String label, double dy) {
    return GestureDetector(
      onTapDown: (_) => widget.game.setVertical(dy),
      onTapUp: (_) => widget.game.setVertical(0),
      onTapCancel: () => widget.game.setVertical(0),
      child: _botaoBase(label, Colors.lightBlue),
    );
  }

  Widget _botaoAcao(String label, VoidCallback onTap, Color cor) {
    return GestureDetector(onTap: onTap, child: _botaoBase(label, cor));
  }

  Widget _botaoBase(String label, Color cor) {
    return Container(
      width: 52, height: 52,
      decoration: BoxDecoration(color: cor.withOpacity(0.6), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white30)),
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontSize: 22)),
    );
  }

  Widget _buildHotbar() {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(4),
        child: Row(mainAxisSize: MainAxisSize.min,
          children: List.generate(Rebeca.hotbar.length, (i) {
            final bloco = Rebeca.hotbar[i];
            final sel = i == _slotAtual;
            return GestureDetector(
              onTap: () { setState(() => _slotAtual = i); widget.game.selecionarSlot(i); },
              child: Container(
                width: 44, height: 44, margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(color: sel ? Colors.white30 : Colors.white12, borderRadius: BorderRadius.circular(4), border: Border.all(color: sel ? Colors.white : Colors.white30, width: sel ? 2 : 1)),
                child: Center(
                  child: Container(width: 28, height: 28,
                    decoration: BoxDecoration(color: bloco.corTopo, borderRadius: BorderRadius.circular(3)),
                    alignment: Alignment.center,
                    child: Text(_icone(bloco), style: const TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  String _icone(TipoBloco b) {
    switch (b) {
      case TipoBloco.grama: return '🌿';
      case TipoBloco.terra: return '🟫';
      case TipoBloco.pedra: return '🪨';
      case TipoBloco.areia: return '🏖';
      case TipoBloco.madeira: return '🪵';
      case TipoBloco.tijolo: return '🧱';
      case TipoBloco.ouro: return '🥇';
      case TipoBloco.diamante: return '💎';
      default: return '■';
    }
  }
}
