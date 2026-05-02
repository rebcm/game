import 'package:passdriver/rebeca_animation/rebeca_animation_page.dart';

class RebecaAnimationRoute {
  static String get routeName => '/rebeca_animation';

  static MaterialPageRoute get route {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => RebecaAnimationPage(),
    );
  }
}
