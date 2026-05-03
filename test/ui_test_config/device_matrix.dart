import 'package:flutter/material.dart';

class DeviceMatrix {
  static const List<DeviceConfig> devices = [
    DeviceConfig(
      name: 'Small Phone',
      screenSize: Size(360, 640),
      textScaleFactor: 1.0,
    ),
    DeviceConfig(
      name: 'Large Phone',
      screenSize: Size(412, 915),
      textScaleFactor: 1.0,
    ),
    DeviceConfig(
      name: 'Tablet',
      screenSize: Size(1280, 800),
      textScaleFactor: 1.0,
    ),
    DeviceConfig(
      name: 'Small Phone Large Text',
      screenSize: Size(360, 640),
      textScaleFactor: 1.5,
    ),
    DeviceConfig(
      name: 'Large Phone Large Text',
      screenSize: Size(412, 915),
      textScaleFactor: 1.5,
    ),
  ];
}

class DeviceConfig {
  final String name;
  final Size screenSize;
  final double textScaleFactor;

  const DeviceConfig({
    required this.name,
    required this.screenSize,
    required this.textScaleFactor,
  });
}
