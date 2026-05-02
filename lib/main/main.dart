import 'package:flutter/material.dart';
import 'package:rebcm/services/asset_manager/asset_manager_provider.dart';
import 'package:rebcm/app.dart';

void main() {
  runApp(
    AssetManagerProvider(
      child: MyApp(),
    ),
  );
}
