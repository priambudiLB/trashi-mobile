import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashi/constants/strings.dart';

import 'bloc/on_boarding_bloc.dart';
import 'components/on_boarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  static const String PATH = "onboardingScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) {
            return OnBoardingBloc();
          },
          child: OnBoardingBody()),
    );
  }
}
