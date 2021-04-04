import 'package:flutter/material.dart';
import 'components/on_boarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  static const String PATH = "onboardingScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingBody()
    );
  }
}
