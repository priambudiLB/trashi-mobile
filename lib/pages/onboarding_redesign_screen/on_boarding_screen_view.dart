import 'package:flutter/material.dart';
import 'package:trashi/pages/onboarding_redesign_screen/components/on_boarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  static const String PATH = "onboardingRedesignScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OnBoardingBody());
  }
}
