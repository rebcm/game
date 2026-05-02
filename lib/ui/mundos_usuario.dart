import 'package:flutter/material.dart';
import 'package:rebcm/api/cloudflare_worker.dart';

class MundosUsuario extends StatefulWidget {
  @override
  _MundosUsuarioState createState() => _MundosUsuarioState();
}

class _MundosUsuarioState extends State<MundosUsuario> {
  final CloudflareWorkerApi _api = CloudflareWorkerApi();
  List<dynamic> _mundos = [];

  Future<void> _carregarMundos() async {
    final userId = 'some-user-id'; // TODO: get real user ID
    final mundos = await _api.getUserWorlds(userId);
    setState(() {
      _mundos = mundos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mundos do Usuário'),
      ),
      body: ListView.builder(
        itemCount: _mundos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_mundos[index]['name']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _carregarMundos,
        tooltip: 'Carregar Mundos',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
