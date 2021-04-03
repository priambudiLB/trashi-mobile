import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashi/constants/strings.dart';
import 'package:trashi/constants/theme.dart';
import 'package:trashi/pages/onboarding_screen/onboarding_screen_view.dart';
import 'package:trashi/pages/splash_screen/bloc/splash_screen_bloc.dart';
import 'package:trashi/pages/splash_screen/bloc/splash_screen_state.dart';
import 'package:trashi/pages/splash_screen/splash_screen.dart';

class TrashiApplication extends StatefulWidget {
  @override
  _TrashiApplicationState createState() => _TrashiApplicationState();
}

class _TrashiApplicationState extends State<TrashiApplication> {
  // ignore: close_sinks
  final SplashScreenBloc _mainBloc = SplashScreenBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // TODO: Add BLOC providers here
          BlocProvider<SplashScreenBloc>(
            create: (context) => SplashScreenBloc(),
          ),
        ],
        child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
          cubit: _mainBloc,
          builder: (context, state) => MaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: child,
            ),
            theme: defaultTheme,
            title: APP_NAME,
            initialRoute: SplashScreen.PATH,
            routes: <String, WidgetBuilder>{
              // TODO: Add more page and define its path here
              SplashScreen.PATH: (_) => SplashScreen(),
              OnboardingScreen.PATH: (_) => OnboardingScreen(),
            },
          ),
        ));
  }
}
