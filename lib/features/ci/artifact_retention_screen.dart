import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:passdriver/providers/ci_provider.dart';
import 'package:provider/provider.dart';

class ArtifactRetentionScreen extends StatefulWidget {
  @override
  _ArtifactRetentionScreenState createState() => _ArtifactRetentionScreenState();
}

class _ArtifactRetentionScreenState extends State<ArtifactRetentionScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _expirationDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de Retenção de Artefatos'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Dias de expiração'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, informe o número de dias';
                }
                if (int.tryParse(value) == null) {
                  return 'Valor inválido';
                }
                return null;
              },
              onSaved: (value) => _expirationDays = int.parse(value!),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await context.read<CiProvider>().updateArtifactRetentionPolicy(_expirationDays!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Política de retenção atualizada')));
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
