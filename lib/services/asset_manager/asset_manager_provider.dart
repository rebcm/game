import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/asset_manager/asset_manager.dart';

class AssetManagerProvider extends StatelessWidget {
  final Widget child;

  const AssetManagerProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AssetManager()),
      ],
      child: child,
    );
  }
}
