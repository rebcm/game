import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class RideHailingMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(-23.550520, -46.633309),
        zoom: 13.0,
        interactive: true,
        tileProvider: TileProvider(
          delegate: NetworkTileProvider(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          noWrap: true,
          tileRetainPadding: EdgeInsets.zero,
          imageFilter: ImageFilter.noFilter,
          imageFilterQuality: FilterQualitynone,
          tileScale: 1.0,
          maxZoom: 19,
          minZoom: 0,
          errorImage: Image.asset('assets/error_image.png'),
          placeholderImage: Image.asset('assets/placeholder_image.png'),
          loadingImage: Image.asset('assets/loading_image.png'),
          loadingErrorImage: Image.asset('assets/loading_error_image.png'),
          tileRequestFactory: (url, headers) => NetworkTileRequest(url, headers),
          tileProviderFactory: () => NetworkTileProvider(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ),
      ),
      layers: [
        TileLayerOptions(
          tileProvider: TileProvider(
            delegate: NetworkTileProvider(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            noWrap: true,
            tileRetainPadding: EdgeInsets.zero,
            imageFilter: ImageFilter.noFilter,
            imageFilterQuality: FilterQuality.none,
            tileScale: 1.0,
            maxZoom: 19,
            minZoom: 0,
            errorImage: Image.asset('assets/error_image.png'),
            placeholderImage: Image.asset('assets/placeholder_image.png'),
            loadingImage: Image.asset('assets/loading_image.png'),
            loadingErrorImage: Image.asset('assets/loading_error_image.png'),
            tileRequestFactory: (url, headers) => NetworkTileRequest(url, headers),
            tileProviderFactory: () => NetworkTileProvider(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
          ),
        ),
      ],
    );
  }
}

