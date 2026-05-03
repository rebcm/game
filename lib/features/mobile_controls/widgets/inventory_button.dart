import 'package:flutter/material.dart';

class InventoryButton extends StatelessWidget {
  final VoidCallback onPressed;

  InventoryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(Icons.shopping_bag),
    );
  }
}
