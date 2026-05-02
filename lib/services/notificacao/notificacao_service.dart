import 'package:http/http.dart' as http;

class NotificacaoService {
  Future<void> notificarNeuronAPI(String evento) async {
    final url = Uri.parse('https://construcao-criativa.workers.dev/notify');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: '{"evento": "$evento"}',
      );
      if (response.statusCode != 200) {
        print('Falha ao notificar Neuron API: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao notificar Neuron API: $e');
    }
  }
}
