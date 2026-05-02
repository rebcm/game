import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class RetentionPolicyScreen extends StatefulWidget {
  @override
  _RetentionPolicyScreenState createState() => _RetentionPolicyScreenState();
}

class _RetentionPolicyScreenState extends State<RetentionPolicyScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _expirationTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de Retenção'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Tempo de expiração (dias)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (int.tryParse(value) == null) {
                  return 'Valor inválido';
                }
                return null;
              },
              onSaved: (value) => _expirationTime = int.parse(value!),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Call API to update retention policy
                  final response = await Provider.of(context, listen: false).updateRetentionPolicy(_expirationTime!);
                  if (response.success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Política de retenção atualizada')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao atualizar política de retenção')));
                  }
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
