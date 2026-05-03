import 'package:intl/intl.dart';

class PseudoLocalization {
  static String extendText(String text) {
    return Intl.message(text * 2, desc: 'Extended text for pseudo-localization');
  }
}
