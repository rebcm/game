import 'package:flutter/material.dart';
import 'package:rebcm/configuracoes/volume/volume_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolumeProvider with ChangeNotifier {
  VolumeConfig _volumeConfig = const VolumeConfig(volume: 1.0, isMuted: false);

  VolumeConfig get volumeConfig => _volumeConfig;

  Future<void> loadVolumeConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final volume = prefs.getDouble('volume') ?? 1.0;
    final isMuted = prefs.getBool('isMuted') ?? false;
    _volumeConfig = VolumeConfig(volume: volume, isMuted: isMuted);
    notifyListeners();
  }

  Future<void> updateVolumeConfig(VolumeConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volume', config.volume);
    await prefs.setBool('isMuted', config.isMuted);
    _volumeConfig = config;
    notifyListeners();
  }
}
