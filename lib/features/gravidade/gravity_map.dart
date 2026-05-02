import 'package:flutter_map/flutter_map.dart';
import 'package:passdriver/features/gravidade/providers/gravity_provider.dart';

class GravityMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GravityProvider>(
      builder: (context, gravityProvider, child) {
        return FlutterMap(
          options: MapOptions(
            center: LatLng(-23.55052, -46.633308),
            zoom: 13,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
          ],
        );
      },
    );
  }
}
