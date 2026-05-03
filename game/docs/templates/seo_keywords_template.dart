import 'package:flutter/material.dart';

class SeoKeywordsTemplate extends StatelessWidget {
  final List<String> keywords;

  const SeoKeywordsTemplate({Key? key, required this.keywords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: keywords.map((keyword) => Text(keyword)).toList(),
    );
  }
}
