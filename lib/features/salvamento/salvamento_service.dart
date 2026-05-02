import Intl.message('package:passdriver/features/salvamento/salvamento_repository.dart');

class SalvamentoService {
  final SalvamentoRepository _repository;

  SalvamentoService(this._repository);

  Future<void> carregarMundo() async {
    await _repository.carregarMundo();
  }
}
