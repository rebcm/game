import 'package:flutter/material.dart';
import 'package:rebcm/utils/stream_subscription_handler.dart';

class AnotherScreen extends StatefulWidget {
  @override
  _AnotherScreenState createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {
  late final StreamSubscriptionHandler _subscriptionHandler;

  @override
  void initState() {
    super.initState();
    _subscriptionHandler = StreamSubscriptionHandler();
    // Example subscription
    // _subscriptionHandler.addSubscription(Stream.periodic(Duration(seconds: 1)).listen((_) {}));
  }

  @override
  void dispose() {
    _subscriptionHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
