import 'package:flutter/material.dart';

class CustomScrollView extends StatefulWidget {
  @override
  _CustomScrollViewState createState() => _CustomScrollViewState();
}

class _CustomScrollViewState extends State<CustomScrollView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(title: Text('Item $index'));
      },
    );
  }
}
