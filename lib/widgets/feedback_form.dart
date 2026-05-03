import 'package:flutter/material.dart';
import 'package:game/services/feedback_service.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackService = FeedbackService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Pergunta 1
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nível de experiência',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione uma opção';
              }
              return null;
            },
          ),
          // Pergunta 2
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Desafios enfrentados',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, forneça uma resposta';
              }
              return null;
            },
          ),
          // Pergunta 3
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Recursos ou funcionalidades faltantes',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, forneça uma resposta';
              }
              return null;
            },
          ),
          // Pergunta 4
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Sugestões para melhorar',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, forneça uma resposta';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Enviar feedback
                _feedbackService.sendFeedback({
                  'nivelExperiencia': 'Iniciante',
                  'desafiosEnfrentados': 'Desafio 1',
                  'recursosFaltantes': 'Recurso 1',
                  'sugestoes': 'Sugestão 1',
                });
              }
            },
            child: Text('Enviar Feedback'),
          ),
        ],
      ),
    );
  }
}
