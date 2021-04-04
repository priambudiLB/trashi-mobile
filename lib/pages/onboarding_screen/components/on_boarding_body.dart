import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/home_screen/home_screen.dart';
import 'package:trashi/pages/navbar_screen/bottom_navbar.dart';
// import 'package:trashi/pages/login_register_screen/welcome_screen.dart';
import 'package:trashi/pages/onboarding_screen/bloc/on_boarding_bloc.dart';
import 'package:trashi/utils/commons.dart';

part 'on_boarding_next_button.dart';
part 'on_boarding_content.dart';
part 'on_boarding_dots.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingBloc, OnBoardingState>(
      listener: (context, state) {
        if (state.isNavigateToHome) {
          //TODO Navigate to register screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavScreen(navIndex: 0)),
          );
          // Navigator.of(context).pushReplacementNamed(HomeScreen.PATH);
        }
      },
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: hexToColor(MAIN_COLOR)),
          child: Column(
            children: [
              Expanded(flex: 8, child: OnBoardingContent()),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OnBoardingNextButton(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    OnBoardingDots(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
