import 'package:game/l10n/l10n.dart';

class Dicas {
  final L10n _l10n;

  Dicas(this._l10n);

  List<String> getDicasStrings() {
    return [
      _l10n.dica1,
      _l10n.dica2,
      // Add more dicas strings here
    ];
  }
}
