import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/dependency_flow.dart';

void main() {
  test('Testa se não há dependência circular', () {
    expect(DependencyFlow.hasCircularDependency(), false);
  });

  test('Testa a direção das dependências', () {
    expect(DependencyFlow.isPresentationDependentOnBusiness(), true);
    expect(DependencyFlow.isBusinessDependentOnData(), true);
    expect(DependencyFlow.isDataDependentOnBusiness(), false);
  });
}
