/// Documentação de Áudio
///
/// Este arquivo contém informações sobre a arquitetura de áudio do projeto Rebeca.
///
/// ## Diagrama de Arquitetura
/// ![Diagrama de Arquitetura de Áudio](../../.github/docs/audio_documentation_checklist/audio_architecture_diagram.png)
///
/// ## Dependências de Plugins
/// | Plugin | Versão | Propósito |
/// | --- | --- | --- |
/// | audioplayers | ^1.0.1 | Reprodução de áudio |

class AudioDocumentation {
  /// Guia de Troubleshooting de Áudio
  static String get troubleshootingGuide => '''
  1. Verifique se o volume está configurado corretamente.
  2. Certifique-se de que o arquivo de áudio está no formato correto.
  ''';

  /// Fluxos de Stream de Áudio
  static String get audioStreamFlows => '''
  1. O áudio é carregado a partir de um arquivo.
  2. O áudio é processado pelo plugin audioplayers.
  3. O áudio é reproduzido pelo sistema.
  ''';
}
