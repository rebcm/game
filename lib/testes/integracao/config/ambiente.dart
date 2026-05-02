enum Ambiente { staging, producao }

class ConfiguracaoAmbiente {
  static String get urlApi {
    switch (Ambiente.staging) {
      case Ambiente.staging:
        return 'https://staging-construcao-criativa.workers.dev';
      case Ambiente.producao:
        return 'https://construcao-criativa.workers.dev';
    }
  }
}
