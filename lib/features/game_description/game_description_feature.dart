import 'package:flutter/material.dart';
import 'package:passdriver/features/game_description/view/game_description_screen.dart';

class GameDescriptionFeature {
  static String route = '/game-description';

  GameDescriptionFeature(this._router);

  final _MyRouter _router;

  void navigate(BuildContext context) {
    _router.navigate(GameDescriptionFeature.route);
  }
}

class _MyRouter {
  void navigate(String route) {
    Navigator.pushNamed(route);
  }
}

class GameDescriptionProvider with ChangeNotifier {
  String _gameDescription = '';

  String get gameDescription => _gameDescription;

  void loadGameDescription() async {
    // Load game description from backend
    final response = await http.get(Uri.parse('https://passdriver-backend.workers.dev/game-description'));
    if (response.statusCode == 200) {
      _gameDescription = response.body;
      notifyListeners();
    } else {
      // Handle error
      print('Erro ao carregar descrição do jogo');
    }
  }
}
