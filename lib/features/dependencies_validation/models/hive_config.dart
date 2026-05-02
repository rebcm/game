import 'package:hive/hive.dart';

part 'hive_config.g.dart';

@HiveType(typeId: 1)
class HiveConfig extends HiveObject {
  @HiveField(0)
  String? key;

  @HiveField(1)
  String? value;

  HiveConfig({this.key, this.value});
}
