import Intl.message('package:flutter/material.dart');
import Intl.message('../jogo/estado_jogo.dart');
import Intl.message('../blocos/tipo_bloco.dart');

class HUD extends StatelessWidget {
  final EstadoJogo estado;
  const HUD({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Barra de status superior
        _barraStatus(),
        // Hotbar inferior
        Align(
          alignment: Alignment.bottomCenter,
          child: _hotbar(),
        ),
        // Inventário completo (quando aberto)
        if (estado.mostrarInventario)
          Center(child: _inventarioCompleto()),
      ],
    );
  }

  Widget _barraStatus() {
    return Positioned(
      top: 8,
      left: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _plaquinha(
            Icons.place,
            Intl.message('X:${estado.rebeca!.x.toStringAsFixed(1)} ')
            Intl.message('Y:${estado.rebeca!.y.toStringAsFixed(1)} ')
            Intl.message('Z:${estado.rebeca!.z.toStringAsFixed(1)}'),
          ),
          const SizedBox(height: 4),
          _plaquinha(Icons.grid_view, Intl.message('+${estado.totalBlocosColocados} blocos')),
        ],
      ),
    );
  }

  Widget _plaquinha(IconData icone, String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, size: 14, color: Colors.white70),
          const SizedBox(width: 4),
          Text(texto, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _hotbar() {
    final rebeca = estado.rebeca!;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(rebeca.inventario.length, (i) {
          final bloco = rebeca.inventario[i];
          final selecionado = i == rebeca.slotselecionado;
          return GestureDetector(
            onTap: () => rebeca.selecionarSlot(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: selecionado ? 54 : 48,
              height: selecionado ? 54 : 48,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: selecionado
                    ? Colors.white.withValues(alpha: 0.25)
                    : Colors.black38,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: selecionado ? Colors.white : Colors.white30,
                  width: selecionado ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: bloco.cor,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: bloco.cor.withValues(alpha: 0.4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    Intl.message('${i + 1}'),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _inventarioCompleto() {
    final todosBlocos = TipoBloco.values.where((b) => b != TipoBloco.ar).toList();
    return Container(
      width: 360,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            Intl.message('🎒 Inventário Criativo'),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: todosBlocos.map((bloco) {
              return GestureDetector(
                onTap: () {
                  final slot = estado.rebeca!.slotselecionado;
                  estado.rebeca!.inventario[slot] = bloco;
                  estado.abrirInventario();
                },
                child: Container(
                  width: 56,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: bloco.cor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bloco.nome,
                        style: const TextStyle(color: Colors.white70, fontSize: 8),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: estado.abrirInventario,
            child: const Text(Intl.message('Fechar [E]'), style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
