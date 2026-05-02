import 'package:flutter/material.dart';
import 'package:rebcm/controllers/base_controller.dart';

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  late final BaseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BaseController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
