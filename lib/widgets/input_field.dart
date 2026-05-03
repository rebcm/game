import 'package:flutter/material.dart';
import 'package:game/utils/focus_detector.dart';

class InputField extends StatefulWidget {
  final String label;

  const InputField({Key? key, required this.label}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FocusDetector _focusDetector = FocusDetector();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _focusDetector.onFocusChange,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: widget.label),
      ),
    );
  }
}
