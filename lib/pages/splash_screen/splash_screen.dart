import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trashi/pages/home_screen/home_screen.dart';
// import 'package:trashi/pages/navbar_screen/default_screen.dart';
import 'package:trashi/pages/onboarding_screen/onboarding_screen_view.dart';
import 'package:trashi/pages/splash_screen/bloc/splash_screen_bloc.dart';
import 'package:trashi/pages/splash_screen/bloc/splash_screen_event.dart';
import 'package:trashi/pages/splash_screen/bloc/splash_screen_state.dart';
import 'package:trashi/pages/splash_screen/splash_screen_view.dart';

class SplashScreen extends StatefulWidget {
  static const String PATH = "splashScreen";
  static const int SPLASH_SCREEN_TIMEOUT_IN_SEC = 2;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SplashScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        new Duration(
          seconds: SplashScreen.SPLASH_SCREEN_TIMEOUT_IN_SEC,
        ), () {
      bloc.add(CheckLoginStatus());
    });
    return BlocListener<SplashScreenBloc, SplashScreenState>(
      cubit: bloc,
      listener: (contex, state) {
        if (state.isUserAccessTokenExist) {
          // User Access Token exist, user is already logged in.
          // Move into home page.
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil(DefaultScreen.PATH, (route) => false);
        } else {
          // User Access Token does not exist, user is not logged in yet.
          // Move into onboarding page.
          Navigator.of(context)
              .pushNamedAndRemoveUntil(OnboardingScreen.PATH, (route) => false);
        }
      },
      child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
        cubit: bloc,
        builder: (context, state) => SplashScreenView(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
