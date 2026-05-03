import 'package:test/test.dart';
import 'package:game/services/dicas/dicas_service.dart';
import 'package:game/docs/dicas_template/template.dart';

void main() {
  test("Deve adicionar dica aprovada", () {
    DicasService service = DicasService();
    Dica dica = Dica(texto: "Dica de teste", aprovacao: true);
    service.adicionarDica(dica);
    expect(service.getDicas().length, 1);
  });

  test("Não deve adicionar dica não aprovada", () {
    DicasService service = DicasService();
    Dica dica = Dica(texto: "Dica de teste", aprovacao: false);
    expect(() => service.adicionarDica(dica), throwsException);
  });
}
