import 'package:flutter/material.dart';

class FocusFilter extends StatefulWidget {
  final Widget child;

  const FocusFilter({Key? key, required this.child}) : super(key: key);

  @override
  State<FocusFilter> createState() => _FocusFilterState();
}

class _FocusFilterState extends State<FocusFilter> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.keyW ||
              event.logicalKey == LogicalKeyboardKey.keyA ||
              event.logicalKey == LogicalKeyboardKey.keyS ||
              event.logicalKey == LogicalKeyboardKey.keyD) {
            if (FocusManager.instance.primaryFocus?.hasPrimaryFocus ?? false) {
              if (FocusManager.instance.primaryFocus?.context?.widget is TextField ||
                  FocusManager.instance.primaryFocus?.context?.widget is TextFormField) {
                return;
              }
            }
            // Call the existing movement logic here
          }
        }
      },
      child: widget.child,
    );
  }
}
