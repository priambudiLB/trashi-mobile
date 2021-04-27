import 'package:flutter/material.dart';
import 'package:trashi/constants/strings.dart';
import 'package:trashi/constants/theme.dart';
import 'package:trashi/pages/home_screen/home_screen.dart';
import 'package:trashi/pages/onboarding_redesign_screen/on_boarding_screen_view.dart';
import 'package:trashi/pages/retribution_screen/retribution_screen.dart';
import 'package:trashi/pages/splash_screen/splash_screen.dart';

class TrashiApplication extends StatelessWidget {
  const TrashiApplication({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      title: APP_NAME,
      initialRoute: SplashScreen.PATH,
      routes: <String, WidgetBuilder>{
        // TODO: Add more page and define its path here
        SplashScreen.PATH: (_) => SplashScreen(),
        OnboardingScreen.PATH: (_) => OnboardingScreen(),
        RetributionScreen.PATH: (_) => RetributionScreen(),
        // HomeScreen.PATH: (_) => HomeScreen(),
      },
    );
  }
}
