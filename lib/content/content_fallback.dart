import 'package:http/http.dart' as http;

class ContentFallback {
  Future<String> getContent() async {
    try {
      // Tentar carregar conteúdo da API
      final response = await http.get(Uri.parse('https://api.example.com/content'));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Se a API falhar, tentar carregar conteúdo local
        return await getLocalContent();
      }
    } catch (e) {
      // Se a API falhar, tentar carregar conteúdo local
      return await getLocalContent();
    }
  }

  Future<String> getLocalContent() async {
    try {
      // Lógica para carregar conteúdo local
      // ...
      return 'Conteúdo local';
    } catch (e) {
      // Se o conteúdo local falhar, retornar conteúdo hardcoded
      return getHardcodedContent();
    }
  }

  String getHardcodedContent() {
    // Retornar conteúdo hardcoded
    return 'Conteúdo hardcoded';
  }
}
