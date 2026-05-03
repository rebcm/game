import 'package:flutter_test/flutter_test.dart';
import 'package:game/docs/estruturas_sugeridas.dart';

void main() {
  test('Estruturas básicas não devem estar vazias', () {
    expect(EstruturasSugeridas.estruturasBasicas, isNotEmpty);
  });

  test('Estruturas complexas não devem estar vazias', () {
    expect(EstruturasSugeridas.estruturasComplexas, isNotEmpty);
  });
}
