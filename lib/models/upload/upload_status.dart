enum UploadStatus { pending, uploading, success, failed }

class UploadTask {
  final File file;
  UploadStatus status;

  UploadTask({required this.file, this.status = UploadStatus.pending});
}
