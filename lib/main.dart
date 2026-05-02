import 'package:flutter/material.dart';
import 'package:rebcm/services/image_cache/image_cache_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ImageCacheService _imageCacheService = ImageCacheService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: _imageCacheService.loadAndResize('https://example.com/image.png', width: 100, height: 100),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Image;
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
