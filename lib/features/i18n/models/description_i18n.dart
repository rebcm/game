import 'package:flutter/material.dart';
import 'package:passdriver/features/i18n/validations/description_i18n_validator.dart';

class DescriptionI18n extends StatefulWidget {
  @override
  _DescriptionI18nState createState() => _DescriptionI18nState();
}

class _DescriptionI18nState extends State<DescriptionI18n> {
  final TextEditingController _descriptionController = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _descriptionController,
      decoration: InputDecoration(
        errorText: _error,
      ),
      onChanged: (text) {
        setState(() {
          _error = DescriptionI18nValidator.validateDescription(text, Localizations.localeOf(context).toString());
        });
      },
    );
  }
}
