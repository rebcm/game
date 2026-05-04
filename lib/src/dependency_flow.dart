class DependencyFlow {
  static bool hasCircularDependency() {
    // Implementação para verificar dependência circular
    return false;
  }

  static bool isPresentationDependentOnBusiness() {
    // Implementação para verificar se apresentação depende de negócios
    return true;
  }

  static bool isBusinessDependentOnData() {
    // Implementação para verificar se negócios depende de dados
    return true;
  }

  static bool isDataDependentOnBusiness() {
    // Implementação para verificar se dados depende de negócios
    return false;
  }
}
