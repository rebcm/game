import 'package:flutter/material.dart';

class BlockWidget extends StatefulWidget {
  @override
  _BlockWidgetState createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget> {
  @override
  Widget build(BuildContext context) {
    rebuildCount++; // increment rebuild count
    return Container(); // actual widget implementation
  }
}

int rebuildCount = 0; // global rebuild count variable
