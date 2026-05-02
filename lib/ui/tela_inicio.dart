import Intl.message('package:flutter/material.dart');
import Intl.message('package:provider/provider.dart');
import Intl.message('../jogo/estado_jogo.dart');
import Intl.message('../config/constantes.dart');
import Intl.message('tela_jogo.dart');

class TelaInicio extends StatefulWidget {
  const TelaInicio({super.key});

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;
  final _ctrlNome = TextEditingController();
  bool _mostrarNovoMundo = false;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _ctrlNome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<EstadoJogo>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D47A1),
              Color(0xFF1565C0),
              Color(0xFF388E3C),
              Color(0xFF2E7D32),
              Color(0xFF5D4037),
            ],
            stops: [0.0, 0.35, 0.55, 0.75, 1.0],
          ),
        ),
        child: Stack(
          children: [
            const _FundoDecorado(),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(scale: _pulseAnim, child: _titulo()),
                      const SizedBox(height: 36),
                      _mostrarNovoMundo
                          ? _cartaoNovoMundo(estado)
                          : _botoesPrincipais(estado),
                      const SizedBox(height: 24),
                      Text(
                        Intl.message('v${Constantes.versao} • ${Constantes.autora}'),
                        style: const TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titulo() {
    return Column(
      children: [
        const Text(Intl.message('🏗️'), style: TextStyle(fontSize: 72)),
        const SizedBox(height: 8),
        const Text(
          Intl.message('Construção Criativa'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          Intl.message('da Rebeca'),
          style: TextStyle(
            color: Color(0xFFA5D6A7),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.5)),
          ),
          child: const Text(
            Intl.message('✨ Modo Criativo Puro'),
            style: TextStyle(color: Colors.greenAccent, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _botoesPrincipais(EstadoJogo estado) {
    return Column(
      children: [
        if (estado.mundoExisteSalvo) ...[
          _botaoPrimario(
            icone: Icons.play_arrow_rounded,
            rotulo: Intl.message('Continuar'),
            subtitulo: estado.nomeDoMundo,
            cor: const Color(0xFF43A047),
            onPressed: () => _jogar(estado, novoMundo: false),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 300,
            child: OutlinedButton.icon(
              onPressed: () {
                _ctrlNome.text = Intl.message('');
                setState(() => _mostrarNovoMundo = true);
              },
              icon: const Icon(Icons.add_circle_outline, color: Colors.white70),
              label: const Text(
                Intl.message('Novo Mundo'),
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ] else ...[
          _botaoPrimario(
            icone: Icons.play_arrow_rounded,
            rotulo: Intl.message('Jogar!'),
            subtitulo: Intl.message('Criar novo mundo'),
            cor: const Color(0xFF43A047),
            onPressed: () {
              _ctrlNome.text = Intl.message('Mundo da Rebeca');
              setState(() => _mostrarNovoMundo = true);
            },
          ),
        ],
      ],
    );
  }

  Widget _cartaoNovoMundo(EstadoJogo estado) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Intl.message('Novo Mundo'),
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(Intl.message('Nome do Mundo'), style: TextStyle(color: Colors.green, fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: _ctrlNome,
            style: const TextStyle(color: Colors.white),
            autofocus: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.green.withValues(alpha: 0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.greenAccent),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              hintText: Intl.message('Mundo da Rebeca'),
              hintStyle: const TextStyle(color: Colors.white30),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _mostrarNovoMundo = false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(Intl.message('Voltar')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => _jogar(estado, novoMundo: true),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text(Intl.message('Criar e Jogar!'), style: TextStyle(fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF43A047),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _botaoPrimario({
    required IconData icone,
    required String rotulo,
    required String subtitulo,
    required Color cor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: cor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rotulo,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitulo,
                    style: const TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _jogar(EstadoJogo estado, {required bool novoMundo}) async {
    final nome =
        _ctrlNome.text.trim().isEmpty ? estado.nomeDoMundo : _ctrlNome.text.trim();
    await estado.iniciarJogo(nome: nome, novoMundo: novoMundo);
    if (!mounted) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const TelaJogo()),
    );
  }
}

class _FundoDecorado extends StatelessWidget {
  const _FundoDecorado();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _FundoPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _FundoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.06);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.12), 60, paint);
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.08), 40, paint);
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.18), 75, paint);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.35), 45, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
