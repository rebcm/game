import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../jogo/estado_jogo.dart';
import '../config/constantes.dart';
import 'tela_jogo.dart';

class TelaInicio extends StatefulWidget {
  const TelaInicio({super.key});

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  final _ctrlNome = TextEditingController(text: 'Mundo da Rebeca');

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _fadeAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _ctrlNome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1565C0), Color(0xFF4CAF50), Color(0xFF795548)],
          ),
        ),
        child: Stack(
          children: [
            _fundo(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: _titulo(),
                  ),
                  const SizedBox(height: 32),
                  _cartaoNomeMundo(),
                  const SizedBox(height: 24),
                  _botoes(),
                  const SizedBox(height: 16),
                  Text(
                    'v${Constantes.versao} • ${Constantes.autora}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fundo() {
    return CustomPaint(
      painter: _FundoNuvens(),
      child: const SizedBox.expand(),
    );
  }

  Widget _titulo() {
    return Column(
      children: [
        Text(
          '🏗️',
          style: TextStyle(fontSize: 64, shadows: [
            Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 8),
          ]),
        ),
        const SizedBox(height: 8),
        Text(
          Constantes.nomeJogo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'Modo Criativo',
          style: TextStyle(color: Colors.greenAccent, fontSize: 16),
        ),
      ],
    );
  }

  Widget _cartaoNomeMundo() {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nome do Mundo',
            style: TextStyle(color: Colors.green, fontSize: 13),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _ctrlNome,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black38,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botoes() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _iniciarJogo,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Jogar!', style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.white70),
          label: const Text('Configurações', style: TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }

  void _iniciarJogo() {
    context.read<EstadoJogo>().iniciarJogo(nome: _ctrlNome.text);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const TelaJogo()),
    );
  }
}

class _FundoNuvens extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.08);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.15), 60, paint);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.1), 40, paint);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.2), 80, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.35), 50, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
