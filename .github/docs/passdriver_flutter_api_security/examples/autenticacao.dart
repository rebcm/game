import 'package:http/http.dart' as http;

Future<void> autenticarUsuario(String username, String password) async {
  final response = await http.post(
    Uri.parse('https://api.example.com/autenticar'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: '{"username": "$username", "password": "$password"}',
  );

  if (response.statusCode == 200) {
    final token = response.body;
    // Armazenar o token de forma segura
  } else {
    // Tratar erro de autenticação
  }
}
