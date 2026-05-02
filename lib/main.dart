import 'package:flutter/material.dart';
import 'package:rebcm/utils/seo/seo_validator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final description = 'Explore and build in a voxel world with Rebeca.';
    final isValid = SeoValidator.validateDescription(description);

    return MaterialApp(
      title: 'Rebeca Voxel Game',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rebeca Voxel Game'),
        ),
        body: Center(
          child: Text('Is description valid: \$isValid'),
        ),
      ),
    );
  }
}
