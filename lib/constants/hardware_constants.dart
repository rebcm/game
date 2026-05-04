class HardwareConstants {
  static const List<String> lowEndDevices = ['Qualcomm Snapdragon 660'];
  static const List<String> midEndDevices = ['Qualcomm Snapdragon 888'];
  static const List<String> highEndDevices = ['Apple A15 Bionic'];

  static const Map<String, int> minFps = {
    'low': 30,
    'mid': 60,
    'high': 90,
  };

  static const Map<String, int> recommendedFps = {
    'low': 60,
    'mid': 90,
    'high': 120,
  };

  static const Map<String, int> maxLoadingTime = {
    'low': 5,
    'mid': 3,
    'high': 2,
  };
}
