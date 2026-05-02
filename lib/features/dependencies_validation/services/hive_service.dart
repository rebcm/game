import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passdriver/features/dependencies_validation/models/hive_config.dart';

class HiveService {
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveConfigAdapter());
  }

  Future<void> storeConfig(HiveConfig config) async {
    var box = await Hive.openBox<HiveConfig>('configBox');
    await box.put(config.key, config);
  }

  Future<HiveConfig?> getConfig(String key) async {
    var box = await Hive.openBox<HiveConfig>('configBox');
    return box.get(key);
  }
}
