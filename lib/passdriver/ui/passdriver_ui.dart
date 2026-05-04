import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/passdriver_data_provider.dart';

class PassdriverUI extends StatefulWidget {
  @override
  _PassdriverUIState createState() => _PassdriverUIState();
}

class _PassdriverUIState extends State<PassdriverUI> {
  late Future<PassdriverDataModel> _passdriverData;

  @override
  void initState() {
    super.initState();
    _passdriverData = PassdriverDataProvider().fetchPassdriverData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _passdriverData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.tips);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
