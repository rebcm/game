import 'package:flutter_test/flutter_test.dart';
import 'package:game/personagem/rebeca.dart';

void main() {
  test('Rebeca initialization', () {
    final rebeca = Rebeca();
    expect(rebeca.x, 0);
    expect(rebeca.y, 0);
    expect(rebeca.z, 0);
  });

  test('Rebeca movement', () {
    final rebeca = Rebeca();
    rebeca.mover(1, 1);
    expect(rebeca.x, 1);
    expect(rebeca.z, 1);
  });

  test('Rebeca jumping', () {
    final rebeca = Rebeca();
    rebeca.pular();
    expect(rebeca.y, greaterThan(0));
  });
}
