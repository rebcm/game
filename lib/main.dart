import Intl.message('package:flutter/material.dart');
import Intl.message('package:audio_optimizer/audio_optimizer_screen.dart');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    Locale(Intl.message('pt'), Intl.message('BR')),
    Locale(Intl.message('en'), Intl.message('US')),
  ],
    return MaterialApp(
      title: Intl.message('PassDriver'),
      home: AudioOptimizerScreen(),
    );
  }
}
