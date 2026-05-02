import 'package:flutter/material.dart';
import 'package:rebcm/services/memory/memory_manager.dart';

class RebecaGame extends StatefulWidget {
  @override
  _RebecaGameState createState() => _RebecaGameState();
}

class _RebecaGameState extends State<RebecaGame> {
  final MemoryManager _memoryManager = MemoryManager();

  @override
  void initState() {
    super.initState();
    // Inicializar o MemoryManager
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: // Seu widget de jogo aqui,
    );
  }

  @override
  void dispose() {
    _memoryManager.collectGarbage();
    super.dispose();
  }
}
