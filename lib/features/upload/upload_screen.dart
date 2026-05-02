import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passdriver/features/upload/providers/upload_notifier.dart';

class UploadScreen extends ConsumerWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUploading = ref.watch(uploadNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Screen'),
      ),
      body: Center(
        child: isUploading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  ref.read(uploadNotifierProvider.notifier).uploadData();
                },
                child: const Text('Upload'),
              ),
      ),
    );
  }
}
