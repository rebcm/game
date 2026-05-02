import Intl.message('package:flutter/material.dart');
import Intl.message('package:flutter_map/flutter_map.dart');
import Intl.message('../utils/filter_configuration.dart');
import Intl.message('../widgets/map_widget.dart');

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

