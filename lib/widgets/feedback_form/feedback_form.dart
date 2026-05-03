import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String _step = '';
  String _issue = '';
  String _suggestion = '';

  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/feedback'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'step': _step,
          'issue': _issue,
          'suggestion': _suggestion,
        }),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback enviado com sucesso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar feedback')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Passo em que ocorreu o problema'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, informe o passo';
              }
              return null;
            },
            onSaved: (value) => _step = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Descrição do problema'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, descreva o problema';
              }
              return null;
            },
            onSaved: (value) => _issue = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Sugestão para melhoria'),
            onSaved: (value) => _suggestion = value ?? '',
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitFeedback,
            child: Text('Enviar Feedback'),
          ),
        ],
      ),
    );
  }
}
