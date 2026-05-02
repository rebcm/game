import 'package:flutter/material.dart';
import 'package:rebcm/widgets/lazy_list.dart';

class MainScreen extends StatelessWidget {
  final List<String> items = List.generate(100, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyList(items: items),
    );
  }
}
