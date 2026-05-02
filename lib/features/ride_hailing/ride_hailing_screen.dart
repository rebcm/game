import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../utils/filter_configuration.dart';
import '../widgets/map_widget.dart';

class RideHailingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RideHailingMap(),
      ),
    );
  }
}

