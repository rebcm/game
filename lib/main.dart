import 'package:flutter/material.dart';
import 'package:rebcm/widgets/mockups.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TooltipMockup(),
              SizedBox(height: 20),
              AjudaMockup(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ModalMockup(),
                  );
                },
                child: Text('Mostrar Modal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
