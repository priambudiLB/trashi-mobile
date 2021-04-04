import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/main.dart';
import 'package:trashi/pages/navbar_screen/bottom_navbar.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

part 'on_boarding_next_button.dart';
part 'on_boarding_content.dart';
part 'on_boarding_dots.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
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
    );
  }
}
