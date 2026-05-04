import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String _setupTime = '';
  String _confusionPoints = '';
  String _missingSteps = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Setup Time'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter setup time';
              }
              return null;
            },
            onSaved: (value) => _setupTime = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Confusion Points'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter confusion points';
              }
              return null;
            },
            onSaved: (value) => _confusionPoints = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Missing Steps'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter missing steps';
              }
              return null;
            },
            onSaved: (value) => _missingSteps = value!,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Send feedback to server or store it locally
                print('Feedback sent: Setup Time: $_setupTime, Confusion Points: $_confusionPoints, Missing Steps: $_missingSteps');
              }
            },
            child: Text('Submit Feedback'),
          ),
        ],
      ),
    );
  }
}
