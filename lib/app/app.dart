import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../jogo/estado_jogo.dart';
import '../ui/tela_inicio.dart';

class AppRebeca extends StatelessWidget {
  const AppRebeca({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EstadoJogo(),
      child: MaterialApp(
        title: 'Construção Criativa da Rebeca',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4CAF50),
            brightness: Brightness.dark,
          ),
          fontFamily: 'monospace',
        ),
        home: const TelaInicio(),
      ),
    );
  }
}
