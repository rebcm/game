import 'package:flutter/material.dart';

class DeployCloudflareProvider with ChangeNotifier {
  bool _buildWebSuccess = false;
  bool _uploadSuccess = false;
  String? _previewUrl;

  bool get buildWebSuccess => _buildWebSuccess;
  bool get uploadSuccess => _uploadSuccess;
  String? get previewUrl => _previewUrl;

  void setBuildWebSuccess(bool success) {
    _buildWebSuccess = success;
    notifyListeners();
  }

  void setUploadSuccess(bool success) {
    _uploadSuccess = success;
    notifyListeners();
  }

  void setPreviewUrl(String? url) {
    _previewUrl = url;
    notifyListeners();
  }

  bool get isDeploySuccessful => _buildWebSuccess && _uploadSuccess && _previewUrl != null;
}
