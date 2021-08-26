import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:trashi/pages/navbar_screen/bottom_navbar.dart';
import 'package:trashi/pages/onboarding_redesign_screen/on_boarding_screen_view.dart';
import 'package:trashi/pages/splash_screen/provider.dart';
// import 'package:trashi/pages/home_screen/home_screen.dart';
// import 'package:trashi/pages/navbar_screen/default_screen.dart';
import 'package:trashi/pages/splash_screen/splash_screen_view.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String PATH = "splashScreen";
  static const int SPLASH_SCREEN_TIMEOUT_IN_SEC = 2;
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashScreenProvider>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<SplashScreenProvider>().fetchingDone &&
        context.watch<SplashScreenProvider>().isLogin) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavScreen(
              navIndex: 2,
            ),
          ),
        );
      });
    } else if (context.watch<SplashScreenProvider>().fetchingDone &&
        !context.watch<SplashScreenProvider>().isLogin) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      });
    }
    return Scaffold(body: SplashScreenView());
  }
}
