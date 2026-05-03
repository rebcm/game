import 'package:flutter/material.dart';
import 'package:game/services/chunk_service/chunk_service.dart';
import 'package:game/utils/rate_limiter/rate_limiter.dart';

void main() {
  final rateLimiter = RateLimiter(maxRequests: 10, timeWindow: Duration(seconds: 1));
  final chunkService = ChunkService(rateLimiter: rateLimiter);

  runApp(MyApp(chunkService: chunkService));
}

class MyApp extends StatelessWidget {
  final ChunkService _chunkService;

  MyApp({required ChunkService chunkService})
      : _chunkService = chunkService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                await _chunkService.fetchChunk('some_chunk_id');
              } catch (e) {
                print(e);
              }
            },
            child: Text('Fetch Chunk'),
          ),
        ),
      ),
    );
  }
}
