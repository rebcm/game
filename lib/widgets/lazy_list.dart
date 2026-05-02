import 'package:flutter/material.dart';

class LazyList extends StatelessWidget {
  final List<String> items;

  const LazyList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(items[index]));
      },
    );
  }
}
