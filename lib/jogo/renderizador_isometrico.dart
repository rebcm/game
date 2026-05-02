import 'package:rebcm/personagem/rebeca.dart';

class RenderizadorIsometrico extends FlameGame {
  late Rebeca _rebeca;

  @override
  Future<void> onLoad() async {
    _rebeca = Rebeca();
    add(_rebeca);
  }
}
