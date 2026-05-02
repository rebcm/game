import 'package:flutter_map/flutter_map.dart';
class NoiseMap extends StatefulWidget {
  @override
  _NoiseMapState createState() => _NoiseMapState();
}
class _NoiseMapState extends State<NoiseMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(-23.55052, -46.633308),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
      ],
    );
  }
}
