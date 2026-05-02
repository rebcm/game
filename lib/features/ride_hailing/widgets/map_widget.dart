import Intl.message('package:flutter/material.dart');
import Intl.message('package:flutter_map/flutter_map.dart');

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
            urlTemplate: Intl.message('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),
            subdomains: [Intl.message('a'), Intl.message('b'), Intl.message('c')],
          ),
          noWrap: true,
          tileRetainPadding: EdgeInsets.zero,
          imageFilter: ImageFilter.noFilter,
          imageFilterQuality: FilterQualitynone,
          tileScale: 1.0,
          maxZoom: 19,
          minZoom: 0,
          errorImage: Image.asset(Intl.message('assets/error_image.png')),
          placeholderImage: Image.asset(Intl.message('assets/placeholder_image.png')),
          loadingImage: Image.asset(Intl.message('assets/loading_image.png')),
          loadingErrorImage: Image.asset(Intl.message('assets/loading_error_image.png')),
          tileRequestFactory: (url, headers) => NetworkTileRequest(url, headers),
          tileProviderFactory: () => NetworkTileProvider(
            urlTemplate: Intl.message('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),
            subdomains: [Intl.message('a'), Intl.message('b'), Intl.message('c')],
          ),
        ),
      ),
      layers: [
        TileLayerOptions(
          tileProvider: TileProvider(
            delegate: NetworkTileProvider(
              urlTemplate: Intl.message('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),
              subdomains: [Intl.message('a'), Intl.message('b'), Intl.message('c')],
            ),
            noWrap: true,
            tileRetainPadding: EdgeInsets.zero,
            imageFilter: ImageFilter.noFilter,
            imageFilterQuality: FilterQuality.none,
            tileScale: 1.0,
            maxZoom: 19,
            minZoom: 0,
            errorImage: Image.asset(Intl.message('assets/error_image.png')),
            placeholderImage: Image.asset(Intl.message('assets/placeholder_image.png')),
            loadingImage: Image.asset(Intl.message('assets/loading_image.png')),
            loadingErrorImage: Image.asset(Intl.message('assets/loading_error_image.png')),
            tileRequestFactory: (url, headers) => NetworkTileRequest(url, headers),
            tileProviderFactory: () => NetworkTileProvider(
              urlTemplate: Intl.message('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),
              subdomains: [Intl.message('a'), Intl.message('b'), Intl.message('c')],
            ),
          ),
        ),
      ],
    );
  }
}

