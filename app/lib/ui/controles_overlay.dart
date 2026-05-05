import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/inventario/crafting.dart';
import 'package:rebcm/inventario/inventario.dart';
import 'package:rebcm/inventario/item.dart';
import 'package:rebcm/jogo/construcao_criativa.dart';
import 'package:rebcm/web_fullscreen.dart';

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
  bool _bagAberta = false;
  bool _craftAberto = false;

  static const double _maxR = 48.0;
  static const double _joySize = 120.0;
  static const List<String> _camLabels = ['NE', 'SE', 'SW', 'NW'];

  Inventario get inv => widget.game.inv;

  @override
  void initState() {
    super.initState();
    inv.addListener(_onInvChange);
    widget.game.hudTick.addListener(_onTick);
  }

  @override
  void dispose() {
    inv.removeListener(_onInvChange);
    widget.game.hudTick.removeListener(_onTick);
    super.dispose();
  }

  void _onInvChange() => setState(() {});
  void _onTick() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(left: 16, bottom: 80, child: _buildJoystick()),
        Positioned(right: 16, bottom: 120, child: _buildAcoes()),
        Positioned(right: 16, top: 96, child: _buildVooButtons()),
        Positioned(right: 16, top: 16, child: _buildMenuTopo()),
        Positioned(left: 16, bottom: 20, child: _buildCamButton()),
        Positioned(bottom: 12, left: 0, right: 0, child: _buildHotbar()),
        Positioned(top: 12, left: 12, child: _buildHud()),
        Positioned(top: 12, left: 0, right: 0, child: Center(child: _buildToast())),
        if (_bagAberta) _buildBagOverlay(),
        if (_craftAberto) _buildCraftOverlay(),
        if (widget.game.morto) _buildMorteOverlay(),
      ],
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
        const SizedBox(height: 8),
        GestureDetector(
          onLongPressStart: (_) => widget.game.iniciarQuebra(),
          onLongPressEnd: (_) => widget.game.pararQuebra(),
          onTap: widget.game.quebrarBlocoImediato,
          child: _botaoWidget('⛏', 'Quebrar', Colors.orange),
        ),
        const SizedBox(height: 8),
        _botaoSimples('⚔', 'Atacar', Colors.red.shade700, () {
          widget.game.atacarMobProximo();
        }),
        const SizedBox(height: 8),
        _botaoSimples('🍖', 'Comer', Colors.amber.shade800, () {
          widget.game.comerSlotAtual();
        }),
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

  Widget _buildMenuTopo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _miniBotao('🖥', 'Tela cheia', Colors.deepPurple, () {
              entrarTelaCheia();
            }),
            const SizedBox(width: 6),
            _miniBotao('💾', 'Salvar', Colors.indigo, () async {
              await widget.game.salvarAgora();
              setState(() {});
            }),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _miniBotao('📦', 'Bag', Colors.brown, () {
              setState(() => _bagAberta = !_bagAberta);
            }),
            const SizedBox(width: 6),
            _miniBotao('⚒', 'Craft', Colors.orange.shade800, () {
              setState(() => _craftAberto = !_craftAberto);
            }),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _miniBotao('📂', 'Carregar', Colors.teal, () async {
              await widget.game.carregarAgora();
              setState(() {});
            }),
            const SizedBox(width: 6),
            _miniBotao('🗑', 'Apagar', Colors.red.shade700, () async {
              await widget.game.apagarSave();
              setState(() {});
            }),
          ],
        ),
      ],
    );
  }

  Widget _miniBotao(String icon, String label, Color cor, VoidCallback onTap,
      {bool wide = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: wide ? 122 : 60,
        height: 32,
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
            Text(icon, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 3),
            Text(label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
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
        return Container(
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
        );
      },
    );
  }

  Widget _buildHud() {
    return Container(
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
            'Câm: ${_camLabels[widget.game.camAngle]} · R=Rodar F=Atacar E=Comer 1-9=Slot',
            style: const TextStyle(color: Colors.white60, fontSize: 9),
          ),
          Text(
            '🕒 ${widget.game.textoTempoDia}    🐾 ${widget.game.mobs.mobs.length}',
            style: const TextStyle(
              color: Colors.amberAccent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          _buildBarras(),
        ],
      ),
    );
  }

  Widget _buildBarras() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBarraIcones('❤', widget.game.hp, widget.game.hpMax, Colors.red.shade400),
        _buildBarraIcones('🍗', widget.game.fome, widget.game.fomeMax, Colors.orange.shade400),
      ],
    );
  }

  Widget _buildBarraIcones(String icone, int v, int max, Color cor) {
    final cheios = (v / 2).ceil();
    final total = (max / 2).ceil();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.5),
          child: Text(
            icone,
            style: TextStyle(
              fontSize: 10,
              color: i < cheios ? cor : Colors.white24,
            ),
          ),
        );
      }),
    );
  }

  /// Hotbar: 9 primeiros slots do inventário.
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
          children: List.generate(Inventario.slotsHotbar, (i) {
            final item = inv.slots[i];
            final sel = i == inv.slotSelecionado;
            return GestureDetector(
              onTap: () => widget.game.selecionarSlot(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: sel ? 52 : 44,
                height: sel ? 52 : 44,
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
                ),
                child: _slotConteudo(item, sel),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _slotConteudo(Item? item, bool sel) {
    if (item == null) {
      return Center(
        child: Text(
          '·',
          style: TextStyle(color: Colors.white12, fontSize: sel ? 20 : 16),
        ),
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: item.isBloco
              ? Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: item.bloco!.corTopo,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.black26, width: 0.5),
                  ),
                  alignment: Alignment.center,
                  child: Text(_iconeBloco(item.bloco!), style: const TextStyle(fontSize: 14)),
                )
              : Text(item.icone, style: const TextStyle(fontSize: 22)),
        ),
        if (item.qtd > 1)
          Positioned(
            right: 2,
            bottom: 0,
            child: Text(
              '${item.qtd}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black87, blurRadius: 2)],
              ),
            ),
          ),
      ],
    );
  }

  /// Bag: 27 slots restantes em grid 9×3.
  Widget _buildBagOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _bagAberta = false),
        child: Container(
          color: Colors.black54,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xCC1a1a2e),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber.withOpacity(0.4), width: 2),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 16)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '📦 Inventário',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (int row = 0; row < 3; row++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(9, (col) {
                        final idx = Inventario.slotsHotbar + row * 9 + col;
                        return _bagSlot(idx);
                      }),
                    ),
                  const SizedBox(height: 14),
                  const Text(
                    '↓ Hotbar (toque para mover) ↓',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(9, (col) => _bagSlot(col)),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => setState(() => _bagAberta = false),
                    child: const Text('Fechar', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bagSlot(int idx) {
    final item = inv.slots[idx];
    final sel = idx == inv.slotSelecionado;
    return GestureDetector(
      onTap: () {
        if (idx < Inventario.slotsHotbar) {
          widget.game.selecionarSlot(idx);
        } else {
          // Toque na bag → tenta swap com slot selecionado da hotbar.
          inv.trocar(idx, inv.slotSelecionado);
        }
      },
      child: Container(
        width: 44,
        height: 44,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: sel ? Colors.amber : Colors.white24,
            width: sel ? 2 : 1,
          ),
        ),
        child: _slotConteudo(item, sel),
      ),
    );
  }

  /// Painel de crafting com receitas disponíveis.
  Widget _buildCraftOverlay() {
    final disponiveis = Crafting.disponiveis(inv, perto: true);
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _craftAberto = false),
        child: Container(
          color: Colors.black54,
          child: Center(
            child: Container(
              width: 360,
              constraints: const BoxConstraints(maxHeight: 480),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xCC1a1a2e),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.orange.withOpacity(0.6), width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '⚒ Crafting',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Workbench virtual ativo. Toque numa receita para criar.',
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                  const SizedBox(height: 10),
                  if (disponiveis.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Sem receitas disponíveis. Junte mais materiais (madeira → pranchas → paus).',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: disponiveis.length,
                        itemBuilder: (ctx, i) {
                          final r = disponiveis[i];
                          return ListTile(
                            dense: true,
                            leading: Text(
                              r.resultado.icone,
                              style: const TextStyle(fontSize: 22),
                            ),
                            title: Text(
                              r.resultado.nome +
                                  (r.resultado.qtd > 1 ? ' ×${r.resultado.qtd}' : ''),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              _resumoReceita(r.custos),
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 10,
                              ),
                            ),
                            onTap: () {
                              Crafting.craftar(inv, r, perto: true);
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () => setState(() => _craftAberto = false),
                    child: const Text('Fechar', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _resumoReceita(List<dynamic> custos) {
    return 'consome materiais';
  }

  /// Tela de game over.
  Widget _buildMorteOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          widget.game.respawnar();
          setState(() {});
        },
        child: Container(
          color: Colors.red.withOpacity(0.5),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('💀', style: TextStyle(fontSize: 88)),
                SizedBox(height: 12),
                Text(
                  'Você morreu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Toque para reviver no spawn',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
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

  String _iconeBloco(TipoBloco b) {
    switch (b) {
      case TipoBloco.grama:     return '🌿';
      case TipoBloco.terra:     return '🟫';
      case TipoBloco.pedra:     return '🪨';
      case TipoBloco.areia:     return '🏖';
      case TipoBloco.madeira:   return '🪵';
      case TipoBloco.folha:     return '🍃';
      case TipoBloco.tijolo:    return '🧱';
      case TipoBloco.vidro:     return '🔲';
      case TipoBloco.ouro:      return '🥇';
      case TipoBloco.diamante:  return '💎';
      case TipoBloco.luz:       return '💡';
      case TipoBloco.neve:      return '❄';
      case TipoBloco.carvao:    return '⬛';
      case TipoBloco.ferro:     return '⚙';
      case TipoBloco.cacto:     return '🌵';
      case TipoBloco.agua:      return '💧';
      case TipoBloco.lava:      return '🔥';
      case TipoBloco.obsidiana: return '⬣';
      default: return '■';
    }
  }
}
