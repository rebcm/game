import 'package:game/docs/walkthrough.dart';

class WalkthroughService {
  final Walkthrough _walkthrough;

  WalkthroughService(this._walkthrough);

  List<String> getWalkthroughSteps() {
    return _walkthrough.getWalkthroughSteps();
  }
}
