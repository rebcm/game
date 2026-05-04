import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  int _setupTime = 0;
  String _confusionPoints = '';
  String _missingSteps = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Feedback'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Setup Time (minutes)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter setup time';
                }
                return null;
              },
              onSaved: (value) => _setupTime = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Points of Confusion'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter points of confusion';
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
                  // TODO: Implement form submission logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Feedback submitted')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
