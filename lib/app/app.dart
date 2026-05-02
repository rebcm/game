import Intl.message('package:flutter/material.dart');
import Intl.message('package:provider/provider.dart');
import Intl.message('../jogo/estado_jogo.dart');
import Intl.message('../ui/tela_inicio.dart');

class AppRebeca extends StatelessWidget {
  const AppRebeca({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EstadoJogo(),
      child: MaterialApp(
        title: Intl.message('Construção Criativa da Rebeca'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4CAF50),
            brightness: Brightness.dark,
          ),
          fontFamily: Intl.message('monospace'),
        ),
        home: const TelaInicio(),
      ),
    );
  }
}
