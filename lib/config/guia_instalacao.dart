class GuiaInstalacao {
  static const String titulo = 'Guia de Instalação';
  static const String versaoFlutter = '3.0.0';
  static const String versaoDart = '2.17.0';
  static const List<String> sdkAndroidNecessario = ['Android SDK 12 (API level 31)'];
  static const List<String> sdkIOSNecessario = ['iOS 15'];
  static const List<String> variaveisAmbiente = ['ANDROID_HOME', 'JAVA_HOME'];
  static const List<String> chavesAPI = ['CLOUDFLARE_API_TOKEN', 'CLOUDFLARE_ACCOUNT_ID'];
  static const List<String> passosValidacao = [
    'Executar `flutter doctor` e verificar se todos os componentes estão configurados corretamente',
    'Executar `flutter pub get` para instalar dependências',
    'Executar `dart analyze` para verificar erros de análise',
    'Executar `flutter run` para iniciar o aplicativo em modo debug'
  ];
}
