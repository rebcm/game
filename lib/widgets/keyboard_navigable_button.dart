import 'package:flutter/material.dart';

class KeyboardNavigableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const KeyboardNavigableButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class KeyboardNavigableFocusableActionDetector extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const KeyboardNavigableFocusableActionDetector({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowFocusHighlight: (value) {},
      onShowHoverHighlight: (value) {},
      actions: {
        ActivateIntent: CallbackAction(onInvoke: (intent) {
          onPressed();
          return null;
        }),
      },
      child: child,
    );
  }
}
