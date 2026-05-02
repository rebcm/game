import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passdriver/features/upload_chunks/presentation/upload_chunks_notifier.dart';

class UploadChunksScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadStatus = ref.watch(uploadChunksNotifierProvider).uploadStatus;
    return Scaffold(
      appBar: AppBar(title: Text('Upload Chunks')),
      body: Center(child: Text('Upload Status: $uploadStatus')),
    );
  }
}
